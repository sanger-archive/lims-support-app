require 'lims-support-app/util/db_handler'
require 'spec_helper'

module Lims::SupportApp
  module Util
    describe DBHandler do
      context "when calling barcode_from_cas method" do
        context "and there is a DB error", :ex => true do
          before do
            Sequel::SQLite::Database.any_instance.stub(:fetch).and_return do
              raise Sequel::Error
            end
          end

          it "raises exception" do
            expect { DBHandler::barcode_from_cas }.to raise_error(Lims::SupportApp::Util::DBHandler::DatabaseError)
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
                [{:dnaplateid => 1}]
              end
            end
          end

          let(:labware_settings)    { YAML.load_file(File.join("config", "labware_db.yml")) }
          let(:number_of_throw_ex)  { labware_settings["number_of_retries"] - 1 }

          it "created a number" do
            DBHandler::barcode_from_cas.should == "1"
          end
        end

        context "should retry a number of times to creating a barcode, throws an error when fails", :ex => true do
          before do
            @times_called = 0
            Sequel::SQLite::Database.any_instance.stub_chain(:fetch, :all).and_return do
              if @times_called < number_of_throw_ex
                @times_called += 1
                raise Sequel::DatabaseError
              end
            end
          end
  
          let(:labware_settings)    { YAML.load_file(File.join("config", "labware_db.yml")) }
          let(:number_of_throw_ex)  { labware_settings["number_of_retries"] }
  
          it "raises an exception" do
            expect { DBHandler::barcode_from_cas }.to raise_error(Lims::SupportApp::Util::DBHandler::DatabaseError)
          end
        end

        context "Sequel::Error raising when there is a DB error" do
          before do

            cas_settings = YAML.load_file(File.join("config", "cas_database.yml"))['test']
            @db_cas = DBHandler::connect_db(cas_settings)

            DBHandler.stub(:plate_id) do
              results = @db_cas.fetch("SELECT").all
            end
          end

          let(:labware_settings)    { YAML.load_file(File.join("config", "labware_db.yml")) }
          let(:number_of_throw_ex)  { labware_settings["number_of_retries"] }

          it "raises an exception" do
            expect { DBHandler::barcode_from_cas }.to raise_error(Lims::SupportApp::Util::DBHandler::DatabaseError) { |exception|
              exception.should be_a(Lims::SupportApp::Util::DBHandler::DatabaseError)
              exception.wrapped_exception.should_not nil
            }
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
        before do
          DBHandler.stub(:find_asset_by_barcode_in_sequencescape).and_return(false)
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
