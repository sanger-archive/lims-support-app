require 'lims-support-app/kit/kit'

module Lims::SupportApp

  describe Kit do

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
        subject {  Kit.new(creation_parameters.except(attribute)) }
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
    let(:process) { "DNA & RNA extraction" }
    let(:aliquot_type) { "NA+P"}
    let(:expires) { Date::civil(2013,05,01) }
    let(:amount) { 10 }
    let(:creation_parameters) { { :process => process,
      :aliquot_type => aliquot_type,
      :expires => expires,
      :amount => amount
    } }

    # validation of the parameter existance
    context "to be valid" do
      subject { Kit.new(creation_parameters)}

      it_needs_a :process
      it_needs_a :aliquot_type
      it_needs_a :expires
      it_needs_a :amount

      it_has_a :process, String
      it_has_a :aliquot_type, String
      it_has_a :expires, Date
      it_has_a :amount, Fixnum
    end

    context "valid" do
      subject { Kit.new(creation_parameters) }
      its(:valid?) { should be_true }
    end

  end
end
