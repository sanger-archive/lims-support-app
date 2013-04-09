# Model requirements
require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
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

      context "test prefix for sanger barcode" do
        let(:labware) { "gel" }
        let(:role) { "gel plate" }
        let(:contents) { "DNA" }
        subject { Barcode.new(
          { :labware => labware, :role => role, :contents => contents }) }
        it {subject.calculate_sanger_barcode_prefix.should == "GD" }
      end

      subject { Barcode.new(creation_parameters)}

      context "test sanger_barcode_prefix method" do
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
        it { subject.calculate_ean13_checksum(code).should == 7 }
      end

      context "test calculate sanger barcode method" do
        let(:sanger_number) { "1234567" }
        it { subject.sanger_barcode_full(sanger_number).should == 274123456781 }
      end

      context "test ean13 calculation" do
        it {
          subject.sanger_code("1233334")
          subject.calculate_ean13.should == "2741233334851"
        }
      end
    end

  end
end
