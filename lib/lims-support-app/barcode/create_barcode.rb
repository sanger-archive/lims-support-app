require 'lims/core/actions/action'

require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
  class Barcode
    class CreateBarcode
      include Lims::Core::Actions::Action

      attribute :labware, String, :required => true, :writer => :private
      attribute :role, String, :required => true, :writer => :private
      attribute :contents, String, :required => true, :writer => :private

      def _call_in_session(session)
        barcode = Lims::SupportApp::Barcode.new(:labware => labware, :role => role, :contents => contents)

        barcode.sanger_code(Barcode::new_barcode)

        barcode.ean13_code = barcode.ean13

        session << barcode
        
        { :barcode => barcode, :uuid => session.uuid_for!(barcode) }
      end
    end
  end

  class Barcode
      Create = CreateBarcode
  end
end