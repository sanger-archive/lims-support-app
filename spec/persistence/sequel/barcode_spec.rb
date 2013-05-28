require 'persistence/sequel/spec_helper'
require 'integrations/spec_helper'
require 'lims-support-app/barcode/barcode_persistor'

module Lims::SupportApp
  describe Barcode::BarcodePersistor do
    include_context "use core context service"

    let(:labware) { "tube" }
    let(:role) { "stock" }
    let(:contents) { "blood" }
    let(:parameters) { { :labware => labware, :role => role, :contents => contents } }
    let(:barcode) { Barcode.new(parameters) }
    let(:sanger_code) { "1233334" }

    context "when created within a session" do
      it "should modify the barcode table" do
        expect do
          store.with_session { |session|
            barcode.ean13_code = "1234567891011"
            session << barcode
          }
        end.to change { db[:barcodes].count}.by(1)
      end

      # TODO we should make it work like this
#      it "can be saved and reloded" do
#        barcode.sanger_code(sanger_code)
#        barcode_id = save(barcode)
#        store.with_session do |session|
#          barcode = session.barcode[barcode_id]
#          barcode.labware.should == labware
#          barcode.role.should == role
#          barcode.contents.should == contents
#          barcode.sanger_barcode.should == sanger_code
#        end
#      end
    end
  end
end