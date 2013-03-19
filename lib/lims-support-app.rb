require 'lims-support-app/version'
require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_barcode'
require 'lims-support-app/barcode/barcode_persistor'

module Lims::Core
  NO_AUTOLOAD = true
end

module Lims
  module SupportApp

    # aliasing the resources and actions
    Lims::Core::Laboratory::Barcode = Lims::SupportApp::Barcode
    Lims::Core::Actions::CreateBarcode = Lims::SupportApp::Barcode::CreateBarcode

    Lims::Core::Persistence::Barcode = Lims::SupportApp::Barcode::BarcodePersistor

    require 'lims-api/server'
    require 'lims-api/context_service'

    Lims::Core::Persistence::finalize_submodule(Lims::Core::Persistence::Sequel, [])
  end

end
