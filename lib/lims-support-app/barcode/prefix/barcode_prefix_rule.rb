module Lims::SupportApp
  module BarcodePrefix
    class BarcodePrefixRule

      def initialize(labware, role, contents, prefix)
        @labware, @role, @contents = labware, role, contents
        @prefix = prefix
      end

      attr_reader :prefix

      def match(labware_triple)
        match_field(labware_triple, :labware) && match_field(labware_triple, :role) && match_field(labware_triple, :contents)
      end

      def match_field(labware_triple, field)
        value = instance_variable_get("@#{field}")
        value_to_match = labware_triple.send(field)
        value.nil? or value.downcase == (value_to_match ? value_to_match.downcase : nil)
      end
      private :match_field
    end
  end
end
