require 'lims-core/resource'
require 'lims-core/base'
require 'lims-core/actions/action'

require 'lims-support-app/barcode/prefix/barcode_prefixes'
require 'lims-support-app/barcode/prefix/labware_triple'
require 'lims-support-app/util/db_handler'
require 'lims-support-app/barcode/barcode_utils'

module Lims::SupportApp

  # A Barcode object is containing the sanger and ean13 type barcode
  # for a labware (like a tube, plate etc...).
  # It has the following parameters:
  # `labware` the specific labware the barcode relates to (tube, plate etc..)
  # `role` the role of the labware (like 'stock')
  # `contents` the type of the aliquot the labware contains (DNA, RNA etc...)
  class Barcode

    class BarcodeFactory
      include Virtus
      include Aequitas
      include Lims::Core::Base::AccessibleViaSuper

      attribute :labware, String, :required => true, :writer => :private, :initializable => true
      attribute :role, String, :required => true, :writer => :private, :initializable => true
      attribute :contents, String, :required => true, :writer => :private, :initializable => true
#      attribute :ean13_code, String, :writer => :private
  
      attr_reader :prefix_from_rule
      attr_reader :generated_sanger_code
  
      # InvalidBarcodeError exception raised if a barcode is not valid.
      # It can happen if the prefix, sanger code or the suffix is nil.
      class InvalidBarcodeError < StandardError
      end

      InvalidBarcodeParameterError = Class.new(Lims::Core::Actions::Action::InvalidParameters)
  
      def initialize(*args, &block)
        super(*args, &block)
        calculate_sanger_barcode_prefix(labware, role, contents)
      end

      def create_barcode
        # This call returns a generated number-like string
        @generated_sanger_code = BarcodeFactory::new_barcode(labware).to_i.to_s
        ean13_code = calculate_ean13

        Lims::SupportApp::Barcode.new(
          :labware                => labware,
          :role                   => role,
          :contents               => contents,
          :sanger_barcode_prefix  => @prefix_from_rule, #BarcodeUtils::sanger_barcode_prefix(ean13_code)
          :sanger_barcode         => BarcodeUtils::sanger_barcode(ean13_code),
          :sanger_barcode_suffix  => BarcodeUtils::sanger_barcode_suffix(ean13_code), #@sanger_suffix,
          :ean13_code             => ean13_code)
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
      def calculate_sanger_barcode_prefix(labware, role, contents)
        labware_triple = BarcodePrefix::LabwareTriple.new(labware, role, contents)
        prefix_rule = BarcodePrefix::BarcodePrefixes.instance.prefixes.find do |rule|
          rule.match(labware_triple)
        end
        @prefix_from_rule = prefix_rule.prefix
#        raise InvalidBarcodeParameterError, "The request cannot be fulfilled due to bad parameter/syntax." if @prefix_from_rule == "??"
#        @prefix_from_rule
      end
      private :calculate_sanger_barcode_prefix
  
#      # This method returns the prefix of a stored sanger barcode
#      # @return [String] the prefix of sanger barcode
#      def sanger_barcode_prefix
#        if @prefix_from_rule.nil?
#          barcode_to_human(@ean13_code)
#          raise InvalidBarcodeError, "Barcode's prefix can't be nil." if @sanger_prefix.nil?
#          @sanger_prefix
#        else
#          @prefix_from_rule
#        end
#      end
  
      
#      # @return [String] the generated sanger code
#      def sanger_code(new_barcode)
#        new_barcode.to_i.to_s
#      end
  
#      # This method retrieve and returns the stored number-like string with 7 digits (padded with '0')
#      # @return [String] the stored sanger code
#      def sanger_barcode
#        barcode_to_human(@ean13_code) if @sanger_code_str.nil?
#        raise InvalidBarcodeError, "Barcode's sanger code can't be nil." if @sanger_code_str.nil?
#        @sanger_code_str
#      end
  
      # This method calculates the suffix of sanger barcode
      # @return [String] the suffix of sanger barcode
      def calculate_sanger_barcode_suffix
        calculate_sanger_barcode_checksum(@prefix_from_rule, @generated_sanger_code)
      end
  
#      # This method returns the stored suffix of sanger barcode
#      # @return [String] the suffix of sanger barcode
#      def sanger_barcode_suffix
#        barcode_to_human(@ean13_code) if @sanger_suffix.nil?
#        raise InvalidBarcodeError, "Barcode's suffix can't be nil." if @sanger_suffix.nil?
#        @sanger_suffix
#      end
  
      # TODO ke4 This is just a temporary solution
      # This is generating a random number with 7 digits
      # This random 'number' should be 7 digit long,
      # if its length is less, then we will pad it with '0' characters
      # It returns a String like '0056349'
      # @return [String] a generated number-like string with 7 digits
      def self.new_barcode(labware)
        Util::DBHandler.next_barcode(labware)
      end
  
      #=== EAN13 Barcode Calculation begins===
  
      # This method is generates an ean13 type barcode from a full sanger-barcode
      # @param [String] an assambled sanger barcode
      # (joining the sanger prefix, sanger code and sanger suffix in one string)
      # @return [String] an ean13 version of the sanger barcode
      def ean13_barcode(sanger_barcode_full)
        ean13 = sanger_barcode_full * 10 + BarcodeUtils::calculate_ean13_checksum(sanger_barcode_full.to_s)
        ("%013d" % ean13)
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
        calculate_sanger_barcode(@prefix_from_rule, sanger_code)
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
  
#      # This method splits the ean13 typed barcode to its prefix, sanger code
#      # and suffix parts. Both of them are in numeric forms.
#      # @return [Array] the ean13 barcode's prefix, sanger code
#      # and suffix in numeric form.
#      def split_barcode(sanger_barcode_full)
#        sanger_barcode_full = sanger_barcode_full.to_s
#        if sanger_barcode_full.size > 11 && sanger_barcode_full.size < 14
#          # Pad with zeros
#          while sanger_barcode_full.size < 13
#            sanger_barcode_full = "0" + sanger_barcode_full
#          end
#        end
#        if /^(...)(.*)(..)(.)$/ =~ sanger_barcode_full
#          prefix, number, check, printer_check = $1, $2, $3, $4
#        end
#        [prefix, number.to_i, check.to_i]
#      end
  
#      # This method converts the ean13 barcode's numeric form
#      # to a human readable form.
#      def barcode_to_human(code)
#        raise InvalidBarcodeError, "An existing barcode object should contain an ean13 type code." if code.nil?
#        prefix, number, suffix = split_barcode(code)
#        @sanger_code_str = "%07d" % number.to_s
#        @sanger_suffix = suffix.chr
#        @sanger_prefix = prefix_to_human(prefix)
#      end
  
#      # This method converts the barcode's prefix from numerical form to
#      # two characters form.
#      def prefix_to_human(prefix)
#        human_prefix = ((prefix.to_i/27)+64).chr + ((prefix.to_i%27)+64).chr
#      end
  
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
end
