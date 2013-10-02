require 'lims-core/resource'
require 'lims-core/base'
require 'lims-core/actions/action'

require 'lims-support-app/barcode/prefix/barcode_prefixes'
require 'lims-support-app/barcode/prefix/labware_triple'
require 'lims-support-app/util/db_handler'
require 'lims-support-app/barcode/barcode_utils'

module Lims::SupportApp

  # This is the BarcodeFactory class. We can create a new insatnce of the barcode
  # object with the create_barcode method.
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

      attr_reader :prefix_from_rule

      def initialize(*args, &block)
        super(*args, &block)
        calculate_sanger_barcode_prefix(labware, role, contents)
      end

      def create_barcode
        ean13_code = calculate_ean13

        Lims::SupportApp::Barcode.new(
          :labware                => labware,
          :role                   => role,
          :contents               => contents,
          :sanger_barcode_prefix  => @prefix_from_rule,
          :sanger_barcode         => BarcodeUtils::sanger_barcode(ean13_code),
          :sanger_barcode_suffix  => BarcodeUtils::sanger_barcode_suffix(ean13_code),
          :ean13_code             => ean13_code)
      end


      private

      # This method returns an ean13 type barcode
      # @return [String] an ean13 version of the sanger barcode
      def calculate_ean13
        # This call returns a generated number-like string
        generated_sanger_code = Barcode::BarcodeFactory::new_barcode(labware).to_i.to_s
        ean13_barcode(sanger_barcode_full(generated_sanger_code)).to_s
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
      end

      # This is generating a number with 7 digits which will be the next barcode.
      # This 'number' should be 7 digit long,
      # if its length is less, then we will pad it with '0' characters
      # It returns a String like '0056349'
      # The input parameter is a labware. In case of 'plate', 'rack'
      # gets the value from the CAS DB. In case of 'tube, 'spin column'
      # gets the value from Sequencescape's DB.
      # @param [String] labware the type of labware
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
  
      #=== Sanger Barcode Calculation ends===
    end
  end
end
