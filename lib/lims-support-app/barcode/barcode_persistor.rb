require 'lims/core/persistence/persistor'
require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
  class Barcode
    # Barcode persistor.
    class BarcodePersistor < Lims::Core::Persistence::Persistor
      Model = Barcode
    end
  end
end
