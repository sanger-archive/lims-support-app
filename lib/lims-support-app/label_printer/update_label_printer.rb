require 'lims-core/actions/action'

require 'lims-support-app/label_printer/label_printer'

module Lims::SupportApp
  class LabelPrinter
    class UpdateLabelPrinter
      include Lims::Core::Actions::Action

      attribute :label_printer, Lims::SupportApp::LabelPrinter, :required => true
      attribute :templates, Array, :required => false
      attribute :label_type, String, :required => false
      attribute :header, String, :required => false
      attribute :footer, String, :required => false

      def _call_in_session(session)
        new_label_printer_templates = []
        templates.each do |template|
          new_label_printer_templates << Lims::SupportApp::LabelPrinter::Template.new(
            :name         => template["name"],
            :description  => template["description"],
            :content      => template["content"])
        end

        label_printer.label_type  = label_type if label_type
        label_printer.header      = header if header
        label_printer.footer      = footer if footer
        update_templates(new_label_printer_templates)

        { :label_printer => label_printer }
      end

      # TODO needs to fix this code
      # currently it can just add new templates
      # and replace old ones with new ones
      def update_templates(new_label_printer_templates)
        while (label_printer.templates.size > new_label_printer_templates.size)
          label_printer.templates.pop
        end

        label_printer.templates.each do |existing_template|
          template = new_label_printer_templates.shift if new_label_printer_templates.size > 0
          if template
            existing_template.name = template.name
            existing_template.description = template.description
            existing_template.content = template.content
          end
        end

        new_label_printer_templates.each do |new_template|
          label_printer.templates << new_template
        end
      end
    end

    Update = UpdateLabelPrinter
  end
end
