require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
  class Barcode
    module CreateActionShared

      def create_barcode(labware, role, contents, session, number_of_barcode=nil)
        barcodes = []
        (number_of_barcode || 1).times do
          barcode = Lims::SupportApp::Barcode.new({
            :labware  => labware,
            :role     => role,
            :contents => contents
          })

          barcode.sanger_code(Barcode::new_barcode)
          barcode.ean13_code = barcode.calculate_ean13
          session << barcode
          barcodes << {:barcode => barcode, :uuid => session.uuid_for!(barcode)}
        end

        number_of_barcode ? {:barcodes => barcodes.map { |b| b[:barcode] }} : barcodes.first
      end
    end
  end
end
