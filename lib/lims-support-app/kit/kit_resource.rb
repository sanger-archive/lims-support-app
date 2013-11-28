require 'lims-laboratory-app/labellable_core_resource'
require 'lims-api/struct_stream'

module Lims::SupportApp
  class Kit
    class KitResource < Lims::LaboratoryApp::LabellableCoreResource

      def content_to_stream(s, mime_type)
        s.add_key "process"
        s.add_value object.process

        s.add_key "aliquotType"
        s.add_value object.aliquot_type

        s.add_key "expires"
        s.add_value object.expires

        s.add_key "amount"
        s.add_value object.amount
      end
    end
  end
end
