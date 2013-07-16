require 'sequel'
require 'logger'
require 'lims-support-app/barcode/barcode'
require 'fix_barcodes/barcode_mapper_constants'

module Lims::SupportApp

  # Opens the Barcode class and override calculate_sanger_barcode_prefix
  # method to add the possibility to give the barcode's prefix from outside
  # of the Barcode class
  class Barcode

    attr_reader :prefix

    def calculate_sanger_barcode_prefix
      return @prefix
    end

    def prefix=(prefix)
      @prefix = prefix
    end
  end


  # Corrects the barcode values in the barcodes DB table and creates a file,
  # which mappes the incorrect ean13 barcodes with the correct ones and
  # adds the correct sanger barcodes, too
  class BarcodeMapper
    include BarcodeMapperConstants

    attr_reader :options
    attr_reader :db
    attr_reader :barcodes_table
    attr_reader :mapping_file

    Loggers = []
    Loggers << Logger.new($stdout)

    def initialize(options)
      @options = options
      init_db
      @mapping_file = init_barcode_mapper_file(@options[:file])
    end

    def init_db
      connection_string = @options[:db] || "sqlite:///Users/ke4/projects/lims-support-app/test.db"
      @db = Sequel.connect(connection_string, :loggers => Loggers)
      @barcodes_table = @db[:barcodes]
    end

    def init_barcode_mapper_file(path)
      unless File.exists?(path)
        dir = File.dirname(path)

        unless File.directory?(dir)
          FileUtils.mkdir_p(dir)
        end

        File.new(path, 'w')
      else
        file = File.open(path, 'w')
      end
    end

    # gets all of the ean13 barcodes from DB
    def ean13_barcodes
      @barcodes_table.select(:ean13_code).all
    end

    # move old values to a new position
    def correct_barcodes
      barcodes_to_fix = []
      old_barcodes = ean13_barcodes

      @db.transaction do
        old_barcodes.each do |existing_ean13_barcode_record|
          existing_ean13_barcode = existing_ean13_barcode_record[:ean13_code]

          unless barcodes_to_fix.include?(existing_ean13_barcode)
            new_barcode = new_code(existing_ean13_barcode)

            new_ean13_barcode = new_barcode[:ean13]
            new_sanger_barcode = new_barcode[:sanger]

            # if the existing barcode is not the same as the newly calculated one,
            # then correct it in the DB and adds a mapping to a file
            # from the old barcodes (ean13 and sanger) to the new ones
            unless new_ean13_barcode == existing_ean13_barcode

              @barcodes_table.where(:ean13_code => existing_ean13_barcode).
                update(:ean13_code => new_ean13_barcode)

              File.open(@mapping_file, 'a') do |file|
                file.write("#{existing_ean13_barcode}#{BarcodeMapperConstants::EAN13_SEPARATOR}#{new_ean13_barcode}#{BarcodeMapperConstants::EAN13_SANGER_SEPARATOR}#{new_sanger_barcode}\n")
              end

              barcodes_to_fix << existing_ean13_barcode
            end
          end
        end
      end
    end

    # calculates the correct ean13 and sanger code
    def new_code(old_ean13_code)
      # creates a barcode object, it's attributes are not important,
      # because later we will override its prefix from the given barcode data
      new_barcode = Lims::SupportApp::Barcode.new(
        { :labware  => "tube", 
          :role     => "stock", 
          :contents => "DNA" 
        }
      )
      prefix, sanger_code = new_barcode.split_barcode(old_ean13_code)
      prefix = new_barcode.prefix_to_human(prefix)
      sanger_code = "%07d" % sanger_code.to_s

      new_barcode.prefix = prefix
      new_barcode.sanger_code(sanger_code)
      new_ean13_code = new_barcode.calculate_ean13
      new_barcode.ean13_code = new_ean13_code

      full_sanger_barcode = prefix + sanger_code + new_barcode.calculate_sanger_barcode_suffix

      { :ean13 => new_ean13_code, :sanger => full_sanger_barcode }
    end
  end

end
