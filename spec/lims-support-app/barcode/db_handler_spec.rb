require 'lims-support-app/util/db_handler'
require 'spec_helper'

module Lims::SupportApp
  module Util
    describe DBHandler do
      context "when calling barcode_from_cas method" do
        context "and there is a DB error", :ex => true do
          before do
            Sequel::SQLite::Database.any_instance.stub(:fetch).and_return do
                raise Sequel::DatabaseError
            end
          end

          it "raises exception" do
            DBHandler::barcode_from_cas.should raise_exception
          end
        end

        context "should retry a number of times to creating a barcode", :ex => true do
          before do
            @times_called = 0
            Sequel::SQLite::Database.any_instance.stub_chain(:fetch, :all).and_return do
              if @times_called < number_of_throw_ex
                @times_called += 1
                raise Sequel::DatabaseError
              else
                [{:DNAPLATEID => 1}]
              end
            end
          end

          let(:number_of_throw_ex) { 2 }

          it "created a number" do
            DBHandler::barcode_from_cas.should == "1"
          end
        end
      end

      context "test the next_barcode method" do
        let(:cas_barcode) { "CAS barcode" }
        let(:sequencescape_barcode) { "Sequencescape barcode" }
        before do
          DBHandler.stub(:barcode_from_cas).and_return(cas_barcode)
        end
        before do
          DBHandler.stub(:create_barcode_asset).and_return(sequencescape_barcode)
        end

        context "get the next barcode with a CAS related labware" do
          let(:labware) { "plate" }

          it "should return a barcode from CAS DB" do
            DBHandler.next_barcode(labware).should == cas_barcode
          end
        end

        context "with sequencescape related labware" do
          let(:labware) { "tube" }

          it "should return a barcode from Sequencescape DB" do
            DBHandler.next_barcode(labware).should == sequencescape_barcode
          end
        end
      end
    end
  end
end
