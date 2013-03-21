module Lims::Core
  NO_AUTOLOAD = true
end

require 'lims-api/resources'
require 'lims-support-app/version'
require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_barcode'
require 'lims-support-app/barcode/barcode_persistor'
require 'lims-support-app/barcode/barcode_resource'

require 'lims-core/persistence/sequel/session'
module Lims::Core

  # TODO ke4 this override is a temporary solution for lims-support-app
  # Remove it after refactoring lims-core persistence layer
  module Persistence
    class Session

      # Get the persistor corresponding to the object class
      # @param [Resource, String, Symbol, Persistor] object
      # @return [Persistor, nil]
      def persistor_for(object)
        if object.is_a?(Persistor)
          return filter_persistor(object)
        end
        name = persistor_name_for(object)
        @persistor_map[name]  ||= begin
          persistor_class = @store.base_module.constant(name)
          raise NameError, "Persistor #{name} not defined for #{@store.base_module.name}" unless persistor_class &&  persistor_class.ancestors.include?(Persistor)
          persistor_class.new(self)
        end
      end

    # Compute the class name of the persistor corresponding to the argument
      # @param [Resource, String, Symbol] object
      # @return [String]
      def  persistor_name_for(object)
        case object
        when String then object
        when Symbol then object.to_s
        when Class,Module
          if object.respond_to?(:base_class)
            return persistor_name_for(object.base_class)
          elsif object.name.include?("Lims::Core") == false
            object.name.sub(/^Lims::SupportApp/, "Lims::Core::Persistence::Sequel") + "Persistor"
          else
            object.name.sub(/^Lims::Core::(Persistence::)?\w+::/, '')
          end
        else persistor_name_for(object.class)
        end.upper_camelcase
      end

    end
  end
end

# aliasing the resources and actions

require 'lims-core/laboratory'
Lims::Core::Laboratory::Barcode = Lims::SupportApp::Barcode
Lims::Core::Actions::CreateBarcode = Lims::SupportApp::Barcode::CreateBarcode
Lims::Core::Persistence::Barcode = Lims::SupportApp::Barcode::BarcodePersistor

module Lims::Api
  module Resources
    BarcodeResource = Lims::SupportApp::Barcode::BarcodeResource
  end
end

require 'lims-core/persistence/sequel'
Lims::Core::Persistence::finalize_submodule(Lims::Core::Persistence::Sequel, [])

require 'lims-api/server'
require 'lims-api/context_service'
