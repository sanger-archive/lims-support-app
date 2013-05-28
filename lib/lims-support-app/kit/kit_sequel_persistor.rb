require 'lims-core/persistence/sequel/persistor'
require 'lims-support-app/kit/kit_persistor'

module Lims::SupportApp
  class Kit
    # Kit Sequel persistor.
    class KitSequelPersistor < KitPersistor
      include Lims::Core::Persistence::Sequel::Persistor

      def self.table_name
        :kits
      end

    end
  end
end