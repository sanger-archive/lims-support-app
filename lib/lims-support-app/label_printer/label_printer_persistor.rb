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
        super(attributes)
      end

      def children_template_proxy(label_printer, children)
        label_printer.templates.each do |template|
          template_proxy = TemplateProxy.new(label_printer, nil, template)
          state = @session.state_for(template_proxy)
          state.resource = template_proxy
          children << template_proxy
        end
      end

      alias template template_proxy

      class TemplateProxy

        def attributes
          (@template.andtap { |t| t.attributes } || {}).tap do |att|
            att[:label_printer] = @label_printer
          end
        end

        def invalid?
          @label_printer.templates.include?(@template) == false
        end

        def on_load
          @label_printer.templates << @template
        end

        class TemplateProxyPersistor

          def parents(resource)
            []
          end

          def parents_for_attributes(att)
            []
          end

          def new_from_attributes(attributes)
            printer = @session.label_printer[attributes.delete(:label_printer_id)]
            super(attributes) do |att|
              template = Template.new(att)
              model.new(printer, nil, template).tap do |proxy|
                proxy.on_load
              end
            end
          end

        end
      end
    end

  end
end
