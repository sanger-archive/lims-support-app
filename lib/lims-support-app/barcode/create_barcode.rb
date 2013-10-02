require 'lims-core/actions/action'

require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_action_shared'

module Lims::SupportApp
  class Barcode
    class CreateBarcode
      include Lims::Core::Actions::Action
      include CreateActionShared

      attribute :labware, String, :required => true, :writer => :private
      attribute :role, String, :required => true, :writer => :private
      attribute :contents, String, :required => true, :writer => :private

      def _call_in_session(session)
        create_barcode(barcode_factory(labware, role, contents), session)
      end
    end
  end

  class Barcode
      Create = CreateBarcode
  end
end
