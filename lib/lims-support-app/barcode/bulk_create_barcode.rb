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
        barcodes = []
        empty_barcode = new_barcode_instance(labware, role, contents)
        number_of_barcodes.times do |nb|
          barcode = empty_barcode.clone
          barcodes << populate_barcode(labware, barcode, session)[:barcode]
        end

        { :barcodes => barcodes }
      end
    end
  end
end
