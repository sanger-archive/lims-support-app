require 'lims-api/core_action_resource'
require 'lims-api/struct_stream'

module Lims::SupportApp
  class Barcode
    class CreatePrintableLabelResource < Lims::Api::CoreActionResource

      # Specific encoder
      module Encoder
        include Lims::Api::CoreActionResource::Encoder

        def status
          unless object.action.invalid_ean13_barcodes.nil? || object.action.invalid_ean13_barcodes.empty?
            400
          else
            200
          end
        end

        def to_stream(s)
          return error_stream(s) unless [200, 201].include?(status)
          super
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
