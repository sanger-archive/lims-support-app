module Lims::SupportApp
  module BarcodePrefix
    class BarcodePrefixRule

      def initialize(labware, role, contents, prefix)
        @labware, @role, @contents = labware, role, contents
        @prefix = prefix
      end

      attr_reader :prefix

      def match(labware_triple)
        matchField(labware_triple, :labware) && matchField(labware_triple, :role) && matchField(labware_triple, :contents)
      end

      def matchField(labware_triple, field)
        value = instance_variable_get("@#{field}")
        value.nil? or labware_triple.send(field) == value
      end
      private :matchField
    end
  end
end
