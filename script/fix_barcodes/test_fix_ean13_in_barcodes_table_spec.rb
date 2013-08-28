require 'integrations/spec_helper'
require(File.expand_path("../fix_ean13_in_barcodes_table", __FILE__))

module Lims::SupportApp

  shared_context "seed barcodes table" do
    before(:each) do
      %w{templates label_printers barcodes kits labels labellables uuid_resources}.each do |table|
        db[table.to_sym].delete
      end
      db[:barcodes].multi_insert(
        [
          {:labware => 'tube_rack', :role => 'stock', :contents => "DNA", :ean13_code => incorrect_barcode},
          {:labware => 'tube_rack', :role => 'stock', :contents => "RNA", :ean13_code => incorrect_barcode}
        ]
      )
    end
  end

  describe BarcodeMapper do

    include_context "use core context service"
    include_context "seed barcodes table"

    context do
      let(:incorrect_barcode) { '3820288261675' }
      let(:correct_barcode) { '3820288261682' }
      let(:options) {
        { :db   => "sqlite:///Users/ke4/projects/lims-support-app/test.db",
          :file => "/Users/ke4/mapping_test.txt",
        }
      }
      let(:barcode_mapper) { BarcodeMapper.new(options) }

      it "correct the ean13_codes in the barcode table" do
        barcode_mapper.correct_barcodes
        barcodes = db[:barcodes].select(:ean13_code).all
        barcodes.each do |barcode_record|
          barcode_record[:ean13_code].should == correct_barcode
        end
      end

      it "creates a file with an entry in it" do
        barcode_mapper.correct_barcodes
        file = File.open(options[:file], 'r')
        file.each_line do |line|
          line.should =~ /#{incorrect_barcode}/
          line.should =~ /#{correct_barcode}/
        end
      end
    end
  end
end
