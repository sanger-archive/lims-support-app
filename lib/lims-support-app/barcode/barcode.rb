require 'common'
require 'lims/core/resource'

require 'lims-support-app/barcode/prefix/barcode_prefixes'
require 'lims-support-app/barcode/prefix/labware_triple'

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
    attribute :ean13_code, String, :writer => :public, :initializable => true

    attr_reader :prefix_from_rule
    attr_reader :generated_sanger_code

    # InvalidBarcodeError exception raised if a barcode is not valid.
    # It can happen if the prefix, sanger code or the suffix is nil.
    class InvalidBarcodeError < StandardError
    end

    def initialize(*args, &block)
      super(*args, &block)
    end

    # This method returns an ean13 type barcode
    # @return [String] an ean13 version of the sanger barcode
    def calculate_ean13
      ean13_barcode(sanger_barcode_full(@generated_sanger_code)).to_s
    end

    # This method returns the prefix of the sanger barcode based on
    # the labware, role and contents of the labware. It is a 2 characters long string.
    # @param [String] the role of the labware (like 'stock')
    # @param [String] the type of the aliquot the labware contains (DNA, RNA etc...)
    # @return [String] the prefix of sanger barcode
    def calculate_sanger_barcode_prefix
      labware_triple = BarcodePrefix::LabwareTriple.new(labware, role, contents)
      prefix_rule = BarcodePrefix::BarcodePrefixes.instance.prefixes.find do |rule|
        rule.match(labware_triple)
      end
      @prefix_from_rule = prefix_rule.prefix
    end

    # This method returns the prefix of a stored sanger barcode
    # @return [String] the prefix of sanger barcode
    def sanger_barcode_prefix
      if @prefix_from_rule.nil?
        barcode_to_human(ean13_code)
        raise InvalidBarcodeError, "Barcode's prefix can't be nil." if @sanger_prefix.nil?
        @sanger_prefix
      else
        @prefix_from_rule
      end
    end

    # This method returns a generated number-like string with 7 digits (padded with '0')
    # @return [String] the generated sanger code
    def sanger_code(new_barcode)
      @generated_sanger_code = ("%07d" % new_barcode.to_i)
    end

    # This method retrieve and returns the stored number-like string with 7 digits (padded with '0')
    # @return [String] the stored sanger code
    def sanger_barcode
      barcode_to_human(ean13_code) if @sanger_code_str.nil?
      raise InvalidBarcodeError, "Barcode's sanger code can't be nil." if @sanger_code_str.nil?
      @sanger_code_str
    end

    # This method calculates the suffix of sanger barcode
    # @return [String] the suffix of sanger barcode
    def calculate_sanger_barcode_suffix
      calculate_sanger_barcode_checksum(calculate_sanger_barcode_prefix, @generated_sanger_code)
    end

    # This method returns the stored suffix of sanger barcode
    # @return [String] the suffix of sanger barcode
    def sanger_barcode_suffix
      barcode_to_human(ean13_code) if @sanger_suffix.nil?
      raise InvalidBarcodeError, "Barcode's suffix can't be nil." if @sanger_suffix.nil?
      @sanger_suffix
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

    # This method is generates an ean13 type barcode from a full sanger-barcode
    # @param [String] an assambled sanger barcode
    # (joining the sanger prefix, sanger code and sanger suffix in one string)
    # @return [String] an ean13 version of the sanger barcode
    def ean13_barcode(sanger_barcode_full)
      sanger_barcode_full * 10 + calculate_ean13_checksum(sanger_barcode_full.to_s)
    end

    # The checksum is calculated taking a varying weight value times the value
    # of each number in the barcode to make a sum. The checksum digit is then
    # the digit which must be added to this sum to get a number evenly
    # divisible by 10 (i.e. the additive inverse of the sum, modulo 10)
    # @param [String] an assambled (full) sanger barcode in one string
    # @return [String] the checksum for ean13 type barcode
    def calculate_ean13_checksum(sanger_barcode_full, initial_weight=3)
      sanger_barcode_full.reverse!
      sum = 0
      weight = initial_weight
      sanger_barcode_full.each_char do |c|
        sum += c.to_i * weight % 10
        weight = weight == 1 ? 3 : 1
      end

      checksum = (10 - sum) % 10
    end

    #=== EAN13 Barcode Calculation ends===

    #=== Sanger Barcode Calculation begins===

    # This method is just delegates call to get the sanger barcode prefix
    # and pass it to a method along with the sanger code, which returns the sanger-barcode in one string
    # @param [String] the role of the labware (like 'stock')
    # @param [String] the type of the aliquot the labware contains (DNA, RNA etc...)
    # @param [String] a generated number-like string with 7 digits
    # @return [String] an assambled sanger barcode
    def sanger_barcode_full(sanger_code)
      calculate_sanger_barcode(calculate_sanger_barcode_prefix, sanger_code)
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

    # This method splits the ean13 typed barcode to its prefix, sanger code
    # and suffix parts. Both of them are in numeric forms.
    # @return [Array] the ean13 barcode's prefix, sanger code
    # and suffix in numeric form.
    def split_barcode(sanger_barcode_full)
      sanger_barcode_full = sanger_barcode_full.to_s
      if sanger_barcode_full.size > 11 && sanger_barcode_full.size < 14
        # Pad with zeros
        while sanger_barcode_full.size < 13
          sanger_barcode_full = "0" + sanger_barcode_full
        end
      end
      if /^(...)(.*)(..)(.)$/ =~ sanger_barcode_full
        prefix, number, check, printer_check = $1, $2, $3, $4
      end
      [prefix, number.to_i, check.to_i]
    end

    # This method converts the ean13 barcode's numeric form
    # to a human readable form.
    def barcode_to_human(ean13_code)
      raise InvalidBarcodeError, "An existing barcode object should contain an ean13 type code." if ean13_code.nil?
      prefix, number, suffix = split_barcode(ean13_code)
      @sanger_code_str = "%07d" % number.to_s
      @sanger_suffix = suffix.chr
      @sanger_prefix = prefix_to_human(prefix)
    end

    # This method converts the barcode's prefix from numerical form to
    # two characters form.
    def prefix_to_human(prefix)
      human_prefix = ((prefix.to_i/27)+64).chr + ((prefix.to_i%27)+64).chr
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
