require 'lims-api/core_resource'
require 'lims-api/struct_stream'
module Lims::SupportApp
  class Barcode
    class BarcodeResource < Lims::Api::CoreResource

      def content_to_stream(s, mime_type)
        sanger_prefix = sanger_prefix(object)
        sanger_number = sanger_number(object)

        s.add_key "ean13"
        s.add_value object.ean13_barcode(sanger_barcode(object, sanger_prefix, sanger_number))

        s.add_key "sanger"
        s.with_hash do
          s.add_key "prefix"
          s.add_value sanger_prefix

          s.add_key "number"
          s.add_value sanger_number

          s.add_key "suffix"
          s.add_value object.calculate_sanger_barcode_checksum(sanger_prefix, sanger_number)
        end
      end

      private
      def sanger_barcode(object, sanger_prefix, sanger_number)
        object.calculate_sanger_barcode(sanger_prefix, sanger_number)
      end

      def sanger_prefix(barcode)
        barcode.prefix_for_sanger_barcode(barcode.role, barcode.contents)
      end

      def sanger_number(barcode)
        barcode.new_barcode
      end
    end
  end
end
