require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
  class Barcode
    module CreateActionShared

      def create_barcode(labware, role, contents, session)
        barcode = Lims::SupportApp::Barcode.new(
          :labware  => labware,
          :role     => role,
          :contents => contents)

        barcode.sanger_code(Barcode::new_barcode)

        barcode.ean13_code = barcode.calculate_ean13

        session << barcode

        { :barcode => barcode, :uuid => session.uuid_for!(barcode) }
      end
    end
  end
end
