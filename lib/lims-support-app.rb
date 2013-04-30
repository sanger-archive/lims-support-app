require 'lims-support-app/version'

require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_barcode'
require 'lims-support-app/barcode/barcode_persistor'
require 'lims-support-app/barcode/barcode_resource'

require 'lims-support-app/kit/kit'
require 'lims-support-app/kit/create_kit'
require 'lims-support-app/kit/kit_persistor'
require 'lims-support-app/kit/kit_sequel_persistor'
require 'lims-support-app/kit/kit_resource'

require 'lims-core/persistence/sequel'
require 'lims-core/persistence/sequel/session'

require 'lims-core/labels/all'

require 'lims-api/server'
require 'lims-api/context_service'

# TODO remove it later, if we have a proper solution for hiding resources
# from lims-core project
require 'hide_resources'
