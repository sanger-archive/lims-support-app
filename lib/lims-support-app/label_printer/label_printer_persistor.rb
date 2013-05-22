require 'lims-core/persistence/persistor'
require 'lims-support-app/label_printer/label_printer'
require 'lims-support-app/label_printer/template'

module Lims::SupportApp
  class LabelPrinter
    # LabelPrinter persistor.
    class LabelPrinterPersistor < Lims::Core::Persistence::Persistor
      Model = LabelPrinter

      def filter_attributes_on_save(attributes)
        attributes.delete(:templates)
        attributes
      end

      def save_children(id, label_printer)
        label_printer["templates"].each do |template|
          @session.save(template, id)
        end
      end

      def load_children(id, label_printer)
        template.loads(id).each do |template|
          label_printer.templates << template
        end
      end

      def template
        @session.label_printer_template
      end
    end

    class Template
      SESSION_NAME = :label_printer_template

      class TemplatePersistor < Lims::Core::Persistence::Persistor
        Model = LabelPrinter::Template

        def filter_attributes_on_save(attributes, label_printer_id=nil)
          attributes[:label_printer_id] = label_printer_id if label_printer_id
          attributes
        end
      end
    end
  end
end
