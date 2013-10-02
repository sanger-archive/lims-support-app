module Lims::SupportApp
  class BarcodeUtils

    # InvalidBarcodeError exception raised if a barcode is not valid.
    # It can happen if the prefix, sanger code or the suffix is nil.
    InvalidBarcodeError = Class.new(StandardError)

    # This method returns the prefix of a stored sanger barcode
    # @return [String] the prefix of sanger barcode
    def self.sanger_barcode_prefix(ean13_code)
      sanger_code = self.barcode_to_human(ean13_code)
      raise InvalidBarcodeError, "Barcode's prefix can't be nil." if sanger_code[:sanger_prefix].nil?
      sanger_code[:sanger_prefix]
    end

    # This method retrieve and returns the stored number-like string with 7 digits (padded with '0')
    # @return [String] the stored sanger code
    def self.sanger_barcode(ean13_code)
      sanger_code = self.barcode_to_human(ean13_code)
      raise InvalidBarcodeError, "Barcode's sanger code can't be nil." if sanger_code[:sanger_code_str].nil?
      sanger_code[:sanger_code_str]
    end

    # This method returns the stored suffix of sanger barcode
    # @return [String] the suffix of sanger barcode
    def self.sanger_barcode_suffix(ean13_code)
      sanger_code = barcode_to_human(ean13_code)
      raise InvalidBarcodeError, "Barcode's suffix can't be nil." if sanger_code[:sanger_suffix].nil?
      sanger_code[:sanger_suffix]
    end

    # The checksum is calculated taking a varying weight value times the value
    # of each number in the barcode to make a sum. The checksum digit is then
    # the digit which must be added to this sum to get a number evenly
    # divisible by 10 (i.e. the additive inverse of the sum, modulo 10)
    # @param [String] an assambled (full) sanger barcode in one string
    # @return [String] the checksum for ean13 type barcode
    def self.calculate_ean13_checksum(sanger_barcode_full, initial_weight=3)
      sanger_barcode_full.reverse!
      sum = 0
      weight = initial_weight
      sanger_barcode_full.each_char do |c|
        sum += c.to_i * weight % 10
        weight = weight == 1 ? 3 : 1
      end

      checksum = (10 - sum) % 10
    end

    private

    # This method converts the ean13 barcode's numeric form
    # to a human readable form.
    def self.barcode_to_human(code)
      raise InvalidBarcodeError, "An existing barcode object should contain an ean13 type code." if code.nil?
      prefix, number, suffix = split_barcode(code)
      { :sanger_code_str  => "%07d" % number.to_s,
        :sanger_suffix    => suffix.chr,
        :sanger_prefix    => prefix_to_human(prefix)
      }
    end

    # This method splits the ean13 typed barcode to its prefix, sanger code
    # and suffix parts. Both of them are in numeric forms.
    # @return [Array] the ean13 barcode's prefix, sanger code
    # and suffix in numeric form.
    def self.split_barcode(sanger_barcode_full)
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

    # This method converts the barcode's prefix from numerical form to
    # two characters form.
    def self.prefix_to_human(prefix)
      human_prefix = ((prefix.to_i/27)+64).chr + ((prefix.to_i%27)+64).chr
    end

  end
end
