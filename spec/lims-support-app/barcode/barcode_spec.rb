# Model requirements
require 'lims-support-app/barcode/barcode'
require 'spec_helper'

module Lims::SupportApp

  shared_examples_for "a valid ean13_code" do |ean13_code|
    it {
      subject.ean13_code.should == ean13_code
      subject.ean13_code.length.should == 13
    }
  end

  shared_examples_for "correct ean13 barcode" do |ean13_code|
    it {
      subject.ean13_code.should == ean13_code
      subject.sanger_barcode_suffix.should == sanger_cheksum
    }
  end

  describe Barcode do
    #== Macro ====
    def self.it_has_a(attribute, type=nil)
      it "responds to #{attribute}" do
        subject.should respond_to(attribute)
      end

      if type
        it "'s #{attribute} is a #{type}" do
          subject.send(attribute).andtap { |v| v.should be_a(type) }
        end
      end
    end

    def self.it_needs_a(attribute)
      context "is invalid" do
        subject {  Barcode.new(creation_parameters.except(attribute)) }
        it { subject.valid?.should == false }
        context "after validation" do
          before { subject.validate }
          it "#{attribute} is required" do
            subject.errors[attribute].should_not be_empty
          end
        end
      end
    end
    #=== End of Macro ===

    # define the parameters
    let(:labware) { "tube" }
    let(:role) { "stock" }
    let(:contents) { "DNA" }
    let(:fake_barcode) { "1233334" }
    let(:creation_parameters) { { :labware => labware,
                                  :role => role,
                                  :contents => contents }
    }

    before do
      Barcode::BarcodeFactory.stub(:new_barcode) do
        fake_barcode
      end
    end

    subject do
      factory = Barcode::BarcodeFactory.new(creation_parameters)
      factory.create_barcode
    end

    # validation of the parameter existance
    context "to be valid" do
      it_needs_a :labware
      it_needs_a :role
      it_needs_a :contents

      it_has_a :labware, String
      it_has_a :role, String
      it_has_a :contents, String
      it_has_a :ean13_code, String
    end

    context "invalid" do
      let(:labware) { "plate" }
      let(:role) { "gel plate test" }
      let(:contents) { "DNA test" }

      it "unsupported parameter triplet results '??' prefix" do
        subject.sanger_barcode_prefix.should == '??'
      end
    end

    context "valid" do
      context "test prefix for sanger barcode - gel plate with DNA" do
        let(:labware) { "gel" }
        let(:role) { "gel plate" }
        let(:contents) { "DNA" }
        it { subject.sanger_barcode_prefix.should == "GD" }
      end

      context "test prefix for sanger barcode - blood" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "blood" }
        it {subject.sanger_barcode_prefix.should == "BL" }
      end

      context "test prefix for sanger barcode and parameters case" do
        let(:labware) { nil }
        let(:role) { "StoCk" }
        let(:contents) { "dna" }
        it {subject.sanger_barcode_prefix.should == "ND" }
      end

      context "test sanger_barcode_prefix method - stock tube with DNA" do
        it {
          subject.sanger_barcode_prefix.should == "JD"
        }
      end

      context "test suffix calculation for sanger barcode" do
        it { subject.sanger_barcode_suffix.should == "U" }
      end

      context "test checksum calculating" do
        let(:code) { "7351353" }
        it { BarcodeUtils::calculate_ean13_checksum(code).should == 7 }
      end

      context "test calculate sanger barcode method" do
        let(:fake_barcode) { "1234567" }
        it { subject.ean13_code.should =~ /274123456781/ }
      end

      context "test ean13 calculation" do
        let(:fake_barcode) { "1233334" }
        it_behaves_like('a valid ean13_code', "2741233334859")
      end

      context "test ean13 calculation with prefix and sanger_code 1" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }
        let(:fake_barcode) { "5991378" }

        it_behaves_like('a valid ean13_code', "3825991378870")
      end

      context "test ean13 calculation with prefix and sanger_code 2" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }
        let(:fake_barcode) { "5539900" }

        it_behaves_like('a valid ean13_code', "3825539900846")
      end

      context "test ean13 calculation with prefix and sanger_code 6911450" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "RNA" }
        let(:fake_barcode) { "6911450" }

        it_behaves_like('a valid ean13_code', "3966911450655")
      end

      context "test ean13 calculation with prefix and sanger_code 6981041" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "RNA" }
        let(:fake_barcode) { "6981041" }

        it_behaves_like('a valid ean13_code', "3966981041876")
      end

      context "test ean13 calculation with CL9027006R" do
        let(:labware) { "tube" }
        let(:role) { "stock" }
        let(:contents) { "cell pellet" }
        let(:fake_barcode) { "9027006" }

        it_behaves_like('a valid ean13_code', "0939027006828")
      end

      context "test barcode creation with a tube" do
        it_behaves_like('a valid ean13_code', '2741233334859')
      end

      context "test barcode creation with a spin column" do
        let(:labware) { "spin column" }
        it_behaves_like('a valid ean13_code', '3821233334758')
      end

      context "test barcode creation with a plate" do
        let(:labware) { "plate" }
        it_behaves_like('a valid ean13_code', '3821233334758')
      end

      context "test barcode creation with a tube rack" do
        let(:labware) { "tube rack" }
        it_behaves_like('a valid ean13_code', '3821233334758')
      end

      context "test barcode creation with a rack" do
        let(:labware) { "tube_rack" }
        let(:role) { "stock" }
        let(:contents) { "RNA" }
        it_behaves_like('a valid ean13_code', '3961233334720')
      end

      context "test barcode creation with a spin column" do
        let(:labware) { " spin_column " }
        let(:role) { "stock" }
        let(:contents) { "RNA" }
        it_behaves_like('a valid ean13_code', '3961233334720')
      end

      context "test ean13 code" do
        let(:labware) { "tube_rack" }
        let(:fake_barcode) { "0288261" }
        let(:sanger_cheksum) { "D" }
        it_behaves_like('correct ean13 barcode', "3820288261682" )
      end

      context "test ean13 code" do
        let(:labware) { "tube_rack" }
        let(:fake_barcode) { "288261" }
        let(:sanger_cheksum) { "D" }
        it_behaves_like('correct ean13 barcode', "3820288261682" )
      end
    end
  end
end
