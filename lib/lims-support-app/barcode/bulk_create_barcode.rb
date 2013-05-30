require 'lims-core/actions/action'

require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_action_shared'

module Lims::SupportApp
  class Barcode
    class BulkCreateBarcode
      include Lims::Core::Actions::Action
      include CreateActionShared

      attribute :labware, String, :required => true, :writer => :private
      attribute :role, String, :required => true, :writer => :private
      attribute :contents, String, :required => true, :writer => :private
      attribute :number_of_barcodes, Numeric, :required => true, :writer => :private

      def _call_in_session(session)
        create_barcode(labware, role, contents, session, number_of_barcodes)
      end
    end
  end
end
