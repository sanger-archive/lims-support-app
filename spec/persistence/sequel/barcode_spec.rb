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

    context "when created within a session" do
      it "should modify the barcode table" do
        expect do
          store.with_session { |session| session << barcode }
        end.to change { db[:barcodes].count}.by(1)
      end
    end
  end
end