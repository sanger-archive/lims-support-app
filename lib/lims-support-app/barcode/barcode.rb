require 'common'

module Lims
  module SupportApp

    # A Barcode object is contains the sanger and ean13 type barcode
    # for a labware (like a tube, plate etc...).
    # It has the following parameters:
    # `labware` the specific labware the barcode relates to (tube, plate etc..)
    # `role` the role of the labware (like 'stocl')
    # `contents` the type of the aliquot the labware contains (DNA, RNA etc...)
    class Barcode

      include Virtus
      include Aequitas

      attribute :labware, String, :required => true, :writer => :private, :initializable => true
      attribute :role, String, :required => true, :writer => :private, :initializable => true
      attribute :contents, String, :required => true, :writer => :private, :initializable => true

      def initialize(*args, &block)
        super(*args, &block)
      end

      # TODO ke4 This is just a temporary solution
      # This is generating a random number with 7 digits
      def new_barcode
        '%07d' % 7.times.map { Random.rand(10) }.join.to_i
      end
      
      def ean13_barcode
        # TODO ke4 uncomment it when sanger_barcode algorythm has been defined properly
#        barcode = sanger_barcode
#        barcode * 10 + calculate_checksum(barcode)
      end

      #=== Sanger Barcode Calculation ===
      def sanger_barcode
        
      end

      def prefix_for_sanger_barcode
        # TODO ke4 I will get info from Matthew later
      end

      def calculate_sanger_barcode(prefix, number)
        number_s = number.to_s
        raise ArgumentError, "Number : #{number} to big to generate a barcode." if number_s.size > 7
        human = prefix + number_s + calculate_sanger_barcode_checksum(prefix, number)
        barcode = prefix_to_number(prefix) + (number * 100)
        barcode = barcode + human[human.size-1]
      end
      private :calculate_sanger_barcode

      def calculate_sanger_barcode_checksum(prefix, number)
        string = prefix + number.to_s
        list = string.split(//)
        len  = list.size
        sum = 0
        list.each do |character|
          sum += character[0] * len
          len = len - 1
        end
        return (sum % 23 + "A"[0]).chr
      end
      private :calculate_sanger_barcode_checksum

      def prefix_to_number(prefix)
        first  = prefix[0]-64
        second = prefix[1]-64
        first  = 0 if first < 0
        second  = 0 if second < 0
        return ((first * 27) + second) * 1000000000
      end
      private :prefix_to_number

      # The checksum is calculated taking a varying weight value times the value
      # of each number in the barcode to make a sum. The checksum digit is then
      # the digit which must be added to this sum to get a number evenly
      # divisible by 10 (i.e. the additive inverse of the sum, modulo 10)
      def calculate_ean13_checksum(code, initial_weight=3)
        sum = 0
        weight = initial_weight
        code.each_char do |c|
          sum += c.to_i * weight
          weight = weight == 1 ? 3 : 1
        end

        checksum = 10 - sum % 10
      end

    end
  end
end