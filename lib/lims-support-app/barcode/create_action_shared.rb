require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/barcode_factory'

module Lims::SupportApp
  class Barcode
    module CreateActionShared

      def barcode_factory(labware, role, contents)
        Barcode::BarcodeFactory.new(
          :labware  => labware,
          :role     => role,
          :contents => contents)
      end

      def create_barcode(factory, session)
        barcode = factory.create_barcode

        session << barcode

        { :barcode => barcode, :uuid => session.uuid_for!(barcode) }
      end

    end
  end
end
