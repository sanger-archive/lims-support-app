require 'lims-core/actions/action'

require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_action_shared'
require 'lims-support-app/barcode/barcode_factory'

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
        barcode_factory = barcode_factory(labware, role, contents)
        number_of_barcodes.times do |nb|
          barcodes << create_barcode(barcode_factory, session)[:barcode]
        end

        { :barcodes => barcodes }
      end
    end
  end
end
