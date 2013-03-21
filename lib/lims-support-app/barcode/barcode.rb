require 'common'
require 'lims/core/resource'

module Lims::SupportApp

  # A Barcode object is containing the sanger and ean13 type barcode
  # for a labware (like a tube, plate etc...).
  # It has the following parameters:
  # `labware` the specific labware the barcode relates to (tube, plate etc..)
  # `role` the role of the labware (like 'stock')
  # `contents` the type of the aliquot the labware contains (DNA, RNA etc...)
  class Barcode

    include Lims::Core::Resource

    attribute :labware, String, :required => true, :writer => :private, :initializable => true
    attribute :role, String, :required => true, :writer => :private, :initializable => true
    attribute :contents, String, :required => true, :writer => :private, :initializable => true
    attribute :ean13_code, String, :writer => :public

    attr_reader :generated_sanger_code

    def initialize(*args, &block)
      super(*args, &block)
    end

    # This hash contains the prefixes for sanger barcode based on
    # the role and the contents of the asset
    def prefix_hash
      { :stock => { "DNA" => "ND", "PDNA" => "NP", "RNA" => "NR",
                    "blood" => "BL", "tumour_tissue" => "TS",
                    "non_tumour_tissue" => "TN",
                    "saliva" => "SV", "pathogen" => "PT"},
        :tube => { "DNA" => "JD", "PDNA" => "JP", "RNA" => "JR"},
        :working_dillution => { "DNA" => "WD", "PDNA" => "WQ", "RNA" => "WR"},
        :pico_dillution => { "DNA" => "QD", "PDNA" => "QP"},
        :pico_assay_a => { "DNA" => "PA", "PDNA" => "PD"},
        :pico_assay_b => { "DNA" => "PB", "PDNA" => "PE"},
        :ribo_dillution => { "RNA" => "QR"},
        :ribo_assay_a => { "RNA" => "RH"},
        :ribo_assay_b => { "RNA" => "RI"},
        :gel_plate => { "DNA" => "GD", "PDNA" => "GQ", "RNA" => "GR"},
        :standard => { "DNA" => "YD", "PDNA" => "YP", "RNA" => "YR"},
        :control => { "DNA" => "XD", "PDNA" => "XP", "RNA" => "XR"},
        :spin_column => { "DNA" => "KD", "PDNA" => "KP", "RNA" => "KR"}
      }
    end
    private :prefix_hash

    # This method returns an ean13 type barcode
    # @return [String] an ean13 version of the sanger barcode
    def ean13
      ean13_barcode(sanger_barcode(role, contents, @generated_sanger_code)).to_s
    end

    # This method returns the prefix of sanger barcode
    # @return [String] the prefix of sanger barcode
    def sanger_barcode_prefix
      prefix_for_sanger_barcode(role, contents)
    end

    # This method returns a generated number-like string with 7 digits (padded with '0')
    # @return [String] the generated sanger code
    def sanger_code(new_barcode)
      @generated_sanger_code = new_barcode
    end

    # This method returns the suffix of sanger barcode
    # @return [String] the suffix of sanger barcode
    def sanger_barcode_suffix
      calculate_sanger_barcode_checksum(sanger_barcode_prefix, @generated_sanger_code)
    end

    # TODO ke4 This is just a temporary solution
    # This is generating a random number with 7 digits
    # This random 'number' should be 7 digit long,
    # if its length is less, then we will pad it with '0' characters
    # It returns a String like '0056349'
    # @return [String] a generated number-like string with 7 digits
    def self.new_barcode
      ('%07d' % 7.times.map { Random.rand(10) }.join.to_i)
    end

    #=== EAN13 Barcode Calculation begins===

    # This method is generates an ean13 type barcode from sanger-barcode
    # @param [String] an assambled sanger barcode
    # (joining the sanger prefix, sanger code and sanger suffix in one string)
    # @return [String] an ean13 version of the sanger barcode
    def ean13_barcode(sanger_barcode)
      sanger_barcode * 10 + calculate_ean13_checksum(sanger_barcode.to_s)
    end

    # The checksum is calculated taking a varying weight value times the value
    # of each number in the barcode to make a sum. The checksum digit is then
    # the digit which must be added to this sum to get a number evenly
    # divisible by 10 (i.e. the additive inverse of the sum, modulo 10)
    # @param [String] an assambled sanger barcode in one string
    # @return [String] the checksum for ean13 type barcode
    def calculate_ean13_checksum(sanger_barcode, initial_weight=3)
      sum = 0
      weight = initial_weight
      sanger_barcode.each_char do |c|
        sum += c.to_i * weight
        weight = weight == 1 ? 3 : 1
      end

      checksum = 10 - sum % 10
    end

    #=== EAN13 Barcode Calculation ends===

    #=== Sanger Barcode Calculation begins===

    # This method is just delegates call to get the sanger barcode prefix
    # and pass it to a method along with the sanger code, which returns the sanger-barcode in one string
    # @param [String] the role of the labware (like 'stock')
    # @param [String] the type of the aliquot the labware contains (DNA, RNA etc...)
    # @param [String] a generated number-like string with 7 digits
    # @return [String] an assambled sanger barcode
    def sanger_barcode(role, contents, sanger_code)
      calculate_sanger_barcode(prefix_for_sanger_barcode(role, contents), sanger_code)
    end

    # This method returns the prefix of the sanger barcode based on the role
    # and contents of the labware. It is a 2 characters long string.
    # @param [String] the role of the labware (like 'stock')
    # @param [String] the type of the aliquot the labware contains (DNA, RNA etc...)
    # @return [String] the prefix of sanger barcode
    def prefix_for_sanger_barcode(role, contents)
      prefix_hash[role.to_sym][contents]
    end

    # This method generates a sanger-barcode into one string
    # joining the prefix, the sanger_code and the sanger suffix
    # @param [String] the prefix of sanger barcode
    # @param [String] a generated number-like string with 7 digits
    # @return [String] an assambled sanger barcode
    def calculate_sanger_barcode(prefix, sanger_code)
      raise ArgumentError, "Number : #{sanger_code} to big to generate a barcode." if sanger_code.size > 7
      human = prefix + sanger_code + calculate_sanger_barcode_checksum(prefix, sanger_code)
      barcode = prefix_to_number(prefix) + (sanger_code.to_i * 100)
      barcode = barcode + human[human.size-1].ord
    end

    # This method calculates the suffix for sanger barcode
    # @param [String] the prefix of sanger barcode
    # @param [String] a generated number-like string with 7 digits
    # @return [String] the sanger barcode's suffix (checksum)
    def calculate_sanger_barcode_checksum(prefix, sanger_code)
      string = prefix + sanger_code
      list = string.split(//)
      len  = list.size
      sum = 0
      list.each do |character|
        sum += character.ord * len
        len = len - 1
      end
      return (sum % 23 + "A".ord).chr
    end

    # This methods convert the textual prefix to numerical value
    # @param [String] the prefix of sanger barcode
    # @return [String] the prefix converted into numerical value
    def prefix_to_number(prefix)
      first  = prefix[0].ord-64
      second = prefix[1].ord-64
      first  = 0 if first < 0
      second  = 0 if second < 0
      return ((first * 27) + second) * 1000000000
    end
    private :prefix_to_number

    #=== Sanger Barcode Calculation ends===

  end
end
