require 'lims-api/core_resource'
require 'lims-api/struct_stream'
module Lims::SupportApp
  class Barcode
    class BarcodeResource < Lims::Api::CoreResource

      def content_to_stream(s, mime_type)
        s.add_key "ean13"
        s.add_value object.ean13_code

        s.add_key "sanger"
        s.with_hash do
          s.add_key "prefix"
          s.add_value object.sanger_barcode_prefix

          s.add_key "number"
          s.add_value object.sanger_barcode

          s.add_key "suffix"
          s.add_value object.sanger_barcode_suffix
        end
      end
    end
  end
end
