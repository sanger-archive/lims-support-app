require 'sequel'

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
      def self.db_initialize(cas_settings, sequenscape_settings)
        @db_cas = Sequel.connect(cas_settings) unless cas_settings.empty?
        @db_sequencescape = Sequel.connect(sequenscape_settings) unless sequenscape_settings.empty?
      end

      # Gets the value of the next barcode
      # In case of 'plate', 'rack' get the value from the CAS DB
      # In case of 'tube, 'spin column' get the value from Sequencescape's DB
      def self.next_barcode(labware)
        raise "CAS DB is not initialized" unless @db_cas
        raise "Sequencescape DB is not initialized" unless @db_sequencescape

        case labware.strip
        when 'plate', 'tube rack', 'tube_rack'
          # gets the new barcode from CAS database
          barcode_from_cas
        when 'tube', 'spin column', 'spin_column'
          # gets the new barcode from Sequencescape DB
          barcode = create_barcode_asset

          while find_asset_by_barcode_in_sequencescape(barcode.to_s)
            barcode = create_barcode_asset
          end

          (barcode).to_s
        else
          raise "The given labware is not supported: #{labware}"
        end
      end

      def self.barcode_from_cas
        results = @db_cas.fetch("SELECT SEQ_DNAPLATE.NEXTVAL AS DNAPLATEID FROM DUAL").all
        results.first[:dnaplateid].to_i.to_s
      end

      private

      # Gets the next barcode value from asset_barcodes table
      def self.create_barcode_asset
        offset = 200000
        asset_barcode_ds = @db_sequencescape[:asset_barcodes]
        asset_barcode_id = asset_barcode_ds.insert
        barcode = asset_barcode_id + offset
      end

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
