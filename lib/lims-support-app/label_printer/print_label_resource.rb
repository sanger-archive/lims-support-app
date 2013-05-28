require 'lims-api/core_action_resource'
require 'lims-api/struct_stream'

module Lims::SupportApp
  class LabelPrinter
    class PrintLabel
      class PrintLabelResource < Lims::Api::CoreActionResource
  
        # Specific encoder
        module Encoder
          include Lims::Api::CoreActionResource::Encoder
  
          def status
            unless object.action.invalid_ean13_barcodes.empty? && object.action.invalid_templates.empty?
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
            error_message = "The request cannot be fulfilled due to bad parameter/syntax."
            unless object.action.invalid_ean13_barcodes.empty?
              error_message += " The following barcode(s) are invalid: "
              error_message = add_faulty_parameters_to_message(object.action.invalid_ean13_barcodes, error_message)
            else
              if !object.action.invalid_templates.empty?
                error_message += " The following template(s) are invalid: "
                error_message = add_faulty_parameters_to_message(object.action.invalid_templates, error_message)
              end
            end
            s.with_hash do
              s.add_key "general"
              s.with_array do
                s.add_value error_message
              end
            end
          end

          def add_faulty_parameters_to_message(faults, error_message)
            error_message += faults.join(', ')
            error_message += "."
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
end
