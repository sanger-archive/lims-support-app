require 'lims-core/persistence/sequel/persistor'
require 'lims-support-app/label_printer/label_printer_persistor'

module Lims::SupportApp
  class LabelPrinter
    # LabelPrinter Sequel persistor.
    class LabelPrinterSequelPersistor < LabelPrinterPersistor
      include Lims::Core::Persistence::Sequel::Persistor

      def self.table_name
        :label_printers
      end
    end

    class Template
      class TemplateSequelPersistor < Lims::SupportApp::LabelPrinter::Template::TemplatePersistor
        include Lims::Core::Persistence::Sequel::Persistor

        def self.table_name
          :templates
        end

        def loads(label_printer_id)
          templates = []
          dataset.filter(:label_printer_id => label_printer_id).all do |att|
            templates << @session.label_printer.template.get_or_create_single_model(att[:id], att)
          end
          templates
        end
      end
    end
  end
end
