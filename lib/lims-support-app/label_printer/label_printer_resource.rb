require 'lims-api/core_resource'
require 'lims-api/struct_stream'

require 'lims-support-app/label_printer/label_printer'
module Lims::SupportApp
  class LabelPrinter
    class LabelPrinterResource < Lims::Api::CoreResource

      def content_to_stream(s, mime_type)
        object.attributes.each do |k,v|
          next if k == :templates
          s.add_key k
          s.add_value v
        end
        templates_to_stream(s, mime_type)
      end

      def templates_to_stream(s, mime_type)
        s.add_key "templates"
        s.with_array do
          object["templates"].each do |template|
            s.with_hash do
              template.attributes.each do |k,v|
                s.add_key k
                s.add_value v
              end
            end
          end
        end
      end

      def creator(attributes)
        attributes[model_name]["uuid"] = uuid
        resource = Lims::SupportApp::LabelPrinter::PrintLabel::PrintLabelResource.new(@context, Lims::SupportApp::LabelPrinter::Print, model_name)
        lambda do
          resource.creator(attributes).call
        end
      end
    end
  end
end
