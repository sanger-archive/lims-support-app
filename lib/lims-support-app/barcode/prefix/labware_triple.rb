require 'virtus'
require 'aequitas/virtus_integration'

module Lims::SupportApp
  module BarcodePrefix
    class LabwareTriple

      include Virtus
      include Aequitas

      attribute :labware, String, :required => true, :writer => :private
      attribute :role, String, :required => true, :writer => :private
      attribute :contents, String, :required => true, :writer => :private

      def initialize(labware, role, contents)
        @labware, @role, @contents = labware, role, contents
      end
      
    end
  end
end
