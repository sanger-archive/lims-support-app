# Model requirements
require 'lims-support-app/barcode/barcode'
require 'spec_helper'

module Lims::SupportApp

  shared_examples_for "a valid ean13_code" do |sanger_code, ean13_code|
    subject { Barcode.new(
      { :labware => labware, :role => role, :contents => contents }) }
    it {
      subject.sanger_code(sanger_code)
      subject.calculate_ean13.should == ean13_code
    }
  end

  shared_examples_for "using new_barcode method" do
    subject { Barcode.new(
      { :labware => labware, :role => role, :contents => contents }) }
    it {
      subject.sanger_code(Barcode::new_barcode(subject.labware))
      subject.calculate_ean13.length.should == 13
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
    let(:creation_parameters) { { :labware => labware,
                                  :role => role,
                                  :contents => contents }
    }

    # validation of the parameter existance
    context "to be valid" do
      subject { Barcode.new(creation_parameters)}

      it_needs_a :labware
      it_needs_a :role
      it_needs_a :contents

      it_has_a :labware, String
      it_has_a :role, String
      it_has_a :contents, String
    end

    context "invalid" do
      subject { Barcode.new(creation_parameters)}

      it "ean13 code can't be nil in a corretly setup barcode object" do
        expect do
          subject.sanger_barcode_prefix.should
        end.to raise_error(Barcode::InvalidBarcodeError)
      end
    end

    context "valid" do
      subject { Barcode.new(creation_parameters)}

      context "test prefix for sanger barcode - gel plate with DNA" do
        let(:labware) { "gel" }
        let(:role) { "gel plate" }
        let(:contents) { "DNA" }
        subject { Barcode.new(
          { :labware => labware, :role => role, :contents => contents }) }
        it {subject.calculate_sanger_barcode_prefix.should == "GD" }
      end

      context "test prefix for sanger barcode - blood" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "blood" }
        subject { Barcode.new(
          { :labware => labware, :role => role, :contents => contents }) }
        it {subject.calculate_sanger_barcode_prefix.should == "BL" }
      end

      subject { Barcode.new(creation_parameters)}

      context "test sanger_barcode_prefix method - stock tube with DNA" do
        it {
          subject.calculate_sanger_barcode_prefix.should == "JD"
        }
      end

      context "test suffix calculation for sanger barcode" do
        let(:prefix) { "JD" }
        let(:number) { "1233334" }
        it { subject.calculate_sanger_barcode_checksum(prefix, number).should == "U" }
      end

      context "test sanger_barcode_suffix method" do
        it {
          subject.sanger_code("1233334")
          subject.calculate_sanger_barcode_suffix.should == "U"
        }
      end

      context "test checksum calculating" do
        let(:code) { "7351353" }
        it { Barcode::calculate_ean13_checksum(code).should == 7 }
      end

      context "test calculate sanger barcode method" do
        let(:sanger_number) { "1234567" }
        it { subject.sanger_barcode_full(sanger_number).should == 274123456781 }
      end

      context "test ean13 calculation" do
        it_behaves_like('a valid ean13_code', "1233334", "2741233334859")
      end

      context "test ean13 calculation with prefix and sanger_code 1" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }

        it_behaves_like('a valid ean13_code', "5991378", "3825991378870")
      end

      context "test ean13 calculation with prefix and sanger_code 2" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }

        it_behaves_like('a valid ean13_code', "5539900", "3825539900846")
      end

      context "test ean13 calculation with prefix and sanger_code 42852" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }

        it_behaves_like('a valid ean13_code', "0042852", "3820042852743")
      end

      context "test ean13 calculation with prefix and sanger_code 564945" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "RNA" }

        it_behaves_like('a valid ean13_code', "0564945", "3960564945773")
      end

      context "test ean13 calculation with prefix and sanger_code 6911450" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "RNA" }

        it_behaves_like('a valid ean13_code', "6911450", "3966911450655")
      end

      context "test ean13 calculation with prefix and sanger_code 6981041" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "RNA" }

        it_behaves_like('a valid ean13_code', "6981041", "3966981041876")
      end

      context "test ean13 calculation with prefix and sanger_code 310543" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }

        it_behaves_like('a valid ean13_code', "0310543", "3820310543823")
      end

      context "test ean13 calculation with prefix and sanger_code 462804" do
        let(:labware) { nil }
        let(:role) { "stock" }
        let(:contents) { "DNA" }

        it_behaves_like('a valid ean13_code', "0462804", "3820462804773")
      end

      context "test new_barcode method with a tube", :focus => true do
        it_behaves_like('using new_barcode method')
      end

      context "test new_barcode method with a spin column", :focus => true do
        let(:labware) { "spin column" }
        it_behaves_like('using new_barcode method')
      end

      context "test new_barcode method with a plate", :focus => true do
        let(:labware) { "plate" }
        it_behaves_like('using new_barcode method')
      end

      context "test new_barcode method with a rack", :focus => true do
        let(:labware) { "tube rack" }
        it_behaves_like('using new_barcode method')
      end
    end
  end
end
