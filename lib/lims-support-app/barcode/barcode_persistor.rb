require 'lims-core/persistence/persistor'
require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/barcode_utils'

module Lims::SupportApp
  class Barcode
    # Barcode persistor.
    class BarcodePersistor < Lims::Core::Persistence::Persistor
      Model = Barcode

      def filter_attributes_on_save(attributes)
        attributes.delete(:sanger_barcode_prefix)
        attributes.delete(:sanger_barcode)
        attributes.delete(:sanger_barcode_suffix)
        attributes
      end

      def filter_attributes_on_load(attributes, *params)
        super(attributes).tap do |attributes|
          attributes[:sanger_barcode_prefix]  = BarcodeUtils::sanger_barcode_prefix(attributes[:ean13_code])
          attributes[:sanger_barcode]         = BarcodeUtils::sanger_barcode(attributes[:ean13_code])
          attributes[:sanger_barcode_suffix]  = BarcodeUtils::sanger_barcode_suffix(attributes[:ean13_code])
        end
      end
    end
  end
end
