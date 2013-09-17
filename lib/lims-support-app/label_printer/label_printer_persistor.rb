require 'lims-laboratory-app/container_persistor_trait'
require 'lims-support-app/label_printer/label_printer'
require 'lims-support-app/label_printer/template'

module Lims::SupportApp
  # LabelPrinter persistor.
  class LabelPrinter

    (does "lims/laboratory_app/container_persistor",
      :element          => :template_proxy,
      :table_name       => :templates,
      :contained_class  => Template)

    class LabelPrinterPersistor

      def filter_attributes_on_save(attributes)
        attributes.delete(:templates)
        attributes
      end

      def children_template_proxy(label_printer, children)
        label_printer.templates.each do |template|
          template_proxy = TemplateProxy.new(label_printer, label_printer.templates, template)
          state = @session.state_for(template_proxy)
          state.resource = template_proxy
          children << template_proxy
        end
      end

      alias template template_proxy

      class TemplateProxy
        SESSION_NAME = :label_printer_template

        def attributes
          @template.attributes
        end

        class TemplateProxyPersistor

          def filter_attributes_on_save(attributes, label_printer_id=nil)
            #TODO label_printer_id?
            attributes[:label_printer_id] = label_printer_id if label_printer_id
            attributes
          end

          def parents_for_attributes(att)
            []
          end
        end
      end
    end

  end
end
