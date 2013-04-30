require 'persistence/sequel/spec_helper'
require 'integrations/spec_helper'
require 'lims-support-app/kit/kit_persistor'

module Lims::SupportApp
  describe Kit::KitPersistor do
    include_context "use core context service"

    let(:process) { "DNA & RNA extraction" }
    let(:aliquot_type) { "NA+P"}
    let(:expires) { Date::civil(2013,05,01) }
    let(:amount) { 10 }
    let(:parameters) { { :process => process,
      :aliquot_type => aliquot_type,
      :expires => expires,
      :amount => amount
    } }
    let(:kit) { Kit.new(parameters) }

    context "when created within a session" do
      it "should modify the kits table" do
        expect do
          store.with_session { |session|
            session << kit
          }
        end.to change { db[:kits].count}.by(1)
      end

      # TODO we should make it work like this
#      it "can be saved and reloded" do
#        kit_id = save(kit)
#        store.with_session do |session|
#          kit = session.kit[kit_id]
#          kit.process.should == process
#          kit.aliquot_type.should == aliquot_type
#          kit.expires.should == expires
#          kit.amount.should == amount
#        end
#      end
    end
  end
end
