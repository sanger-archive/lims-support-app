require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
  class Barcode
    module CreateActionShared

      def new_barcode_instance(labware, role, contents)
        barcode = Lims::SupportApp::Barcode.new(
                  :labware  => labware,
                  :role     => role,
                  :contents => contents)
      end

      def populate_barcode(labware, barcode, session)
        barcode.sanger_code(Barcode::new_barcode(labware))

        barcode.ean13_code = barcode.calculate_ean13

        session << barcode

        { :barcode => barcode, :uuid => session.uuid_for!(barcode) }
      end
    end
  end
end
