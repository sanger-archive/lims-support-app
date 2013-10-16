require 'lims-support-app/barcode/prefix/barcode_prefix_rule'
require 'singleton'
require 'lims-core/helpers'

module Lims::SupportApp
  module BarcodePrefix
    class BarcodePrefixes
      include Singleton

      attr_reader :prefixes

      def load_prefixes
        Lims::Core::Helpers::load_json(IO.read(File.join("config", "barcode_prefixes.json"))).collect do |rule|
          BarcodePrefixRule.new(rule["labware"], rule["role"], rule["contents"], rule["prefix"])
        end
      end

      def prefixes
        @prefixes ||= load_prefixes
      end
    end
  end
end
