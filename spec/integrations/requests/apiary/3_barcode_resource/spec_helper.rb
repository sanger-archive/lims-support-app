require "integrations/requests/apiary/spec_helper"
# This file will be required by
# all file in this directory and subdirectory

# We are mocking the new barcode generation.
# The FakeBarcode class is defined in the 'setup' part of the related 'erb' file
module Lims::SupportApp
  class Barcode
    class BarcodeFactory
      def self.new_barcode(labware)
        Lims::SupportApp::FakeBarcode::new_fake_barcode
      end
    end
  end
end
