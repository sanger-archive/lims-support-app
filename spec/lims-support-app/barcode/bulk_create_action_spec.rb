require 'lims-support-app/barcode/bulk_create_barcode'
require 'lims-support-app/barcode/barcode'
require 'lims-core/persistence/store'
require 'lims-support-app/spec_helper'
require 'spec_helper'

module Lims::SupportApp
  describe Barcode::BulkCreateBarcode do

    shared_examples_for "bulk creating barcodes" do
      include_context "create object"
      it_behaves_like "an action"

      it "creates barcode objects" do
        Lims::Core::Persistence::Session.any_instance.should_receive(:save)
        result = subject.call
        barcodes = result[:barcodes]
        barcodes.should be_a(Array)
        barcodes.size.should == number_of_barcodes
        barcodes.each do |barcode|
          barcode.should be_a(Lims::SupportApp::Barcode)
        end
      end
    end

    include_context "for application", "bulk barcode creation"
    let!(:store) { Lims::Core::Persistence::Store.new }
    # define the parameters
    let(:labware) { "tube" }
    let(:role) { "stock" }
    let(:contents) { "DNA" }
    let(:number_of_barcodes) { 2 }
    let(:parameters) { {
      :labware            => labware,
      :role               => role,
      :contents           => contents,
      :number_of_barcodes => number_of_barcodes
    } }

    context "invalid action" do
      it "requires a valid number of barcodes" do
        described_class.new(parameters.merge({:number_of_barcodes => -1})).valid?.should == false
      end

      it "requires a labware" do
        described_class.new(parameters - [:labware]).valid?.should == false
      end

      it "requires a role" do
        described_class.new(parameters - [:role]).valid?.should == false
      end

      it "requires a contents" do
        described_class.new(parameters - [:contents]).valid?.should == false
      end
    end

    context "valid action" do
      subject {
        described_class.new(:store => store, :user => user, :application => application) do |action, session|
          parameters.each do |key, value|
            action.send("#{key}=", value)
          end
        end
      }

     it_behaves_like "bulk creating barcodes"
    end
  end
end
