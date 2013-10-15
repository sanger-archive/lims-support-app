require 'sequel'
require 'virtus'
require 'aequitas'

module Lims::SupportApp

  module Util
    class DBHandler
      include Virtus
      include Aequitas

      attribute :db_cas, Sequel::Database, :required => true, :writer => :private, :reader => :private
      attribute :db_sequencescape, Sequel::Database, :required => true, :writer => :private, :reader => :private
  
      # Initilize the DBHandler class
      # @param [Hash] cas DB settings
      # @param [Hash] Sequencescape DB settings
      def self.db_initialize(cas_settings, sequenscape_settings, labware_settings)
        @db_cas                 = Sequel.connect(cas_settings) unless cas_settings.empty?
        @db_sequencescape       = Sequel.connect(sequenscape_settings) unless sequenscape_settings.empty?
        @cas_labware            = labware_settings["cas"]
        @retries                = labware_settings["number_of_retries"]
      end

      # Gets the value of the next barcode
      # In case of 'plate', 'rack' get the value from the CAS DB
      # In case of 'tube, 'spin column' get the value from Sequencescape's DB
      def self.next_barcode(labware)
        raise "CAS DB is not initialized" unless @db_cas
        raise "Sequencescape DB is not initialized" unless @db_sequencescape

        if @cas_labware.include?(labware.strip.downcase)
          # gets the new barcode from CAS database
          barcode_from_cas
        else
          # gets the new barcode from Sequencescape DB
          barcode = create_barcode_asset

          while find_asset_by_barcode_in_sequencescape(barcode.to_s)
            # gets the next barcode value from asset_barcodes table
            barcode = create_barcode_asset
          end

          (barcode).to_s
        end
      end

      def self.create_barcode_asset
        @db_sequencescape[:asset_barcodes].insert
      end

      def self.barcode_from_cas
        tries ||= @retries
        results = @db_cas.fetch("SELECT SEQ_DNAPLATE.NEXTVAL AS DNAPLATEID FROM DUAL").all
        results.first[:dnaplateid].to_i.to_s
      rescue Sequel::DatabaseError
        retry unless (tries -= 1).zero?
      end

      private

      # Checks asset existence with the given barcode in SS's assets table
      def self.find_asset_by_barcode_in_sequencescape(barcode)
        found = false
        asset_ds = @db_sequencescape[:assets]
        result = asset_ds.where(:barcode => barcode).all
        unless result.empty?
          found = true
        end
        found
      end

    end
  end
end
