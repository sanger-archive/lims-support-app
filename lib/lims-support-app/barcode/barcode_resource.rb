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

      # Specific encoder
      module Encoder
        include Lims::Api::CoreResource::Encoder

        def status
          if object.object.sanger_barcode_prefix == '??'
            400
          else
            200
          end
        end

        def to_stream(s)
          return error_stream(s) unless [200, 201].include?(status)
          s.tap do
            s.with_hash do
              s.add_key object.model_name.to_s
              s.with_hash do
                to_hash_stream(s)
              end
            end
          end
        end

        def error_stream(s)
          s.with_hash do
            s.add_key "general"
            s.with_array do
              s.add_value "The request cannot be fulfilled due to bad parameter/syntax."
            end
          end
        end

      end

      Encoders = [
        class JsonEncoder
          include Encoder
          include Lims::Api::JsonEncoder
        end
      ]

      def self.encoder_class_map
        Encoders.mash { |k| [k::ContentType, k] }
      end

    end
  end
end
