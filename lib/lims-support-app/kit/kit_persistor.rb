require 'lims/core/persistence/persistor'
require 'lims-support-app/kit/kit'

module Lims::SupportApp
  class Kit
    # Kit persistor.
    class KitPersistor < Lims::Core::Persistence::Persistor
      Model = Kit
    end
  end
end
