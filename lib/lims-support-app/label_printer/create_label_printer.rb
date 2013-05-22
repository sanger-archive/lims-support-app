require 'lims-core/actions/action'

require 'lims-support-app/label_printer/label_printer'

module Lims::SupportApp
  class LabelPrinter
    class CreateLabelPrinter
      include Lims::Core::Actions::Action

      attribute :name, String, :required => true, :writer => :private, :initializable => true
      attribute :templates, Array, :required => true, :writer => :private, :initializable => true
      attribute :label_type, String, :required => true, :writer => :private, :initializable => true

      def _call_in_session(session)
        label_printer_templates = []
        templates.each do |template|
          label_printer_templates << Lims::SupportApp::LabelPrinter::Template.new(
            :name         => template["name"],
            :description  => template["description"],
            :content      => template["content"])
        end

        label_printer = LabelPrinter.new(:name => name,
          :templates  => label_printer_templates,
          :label_type => label_type)

        session << label_printer

        { :label_printer => label_printer, :uuid => session.uuid_for!(label_printer) }
      end
    end

    Create = CreateLabelPrinter
  end
end
