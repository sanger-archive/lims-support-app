require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "create_an_invalid_barcode_object" do
  include_context "use core context service"
  it "create_an_invalid_barcode_object" do
  # **Use the create barcode action to create a barcode with invalid parameters.**
  # * `labware` the specific labware the barcode relates to (tube, plate etc..)
  # * `role` the role of the labware (like 'stock')
  # * `contents` the type of the aliquot the labware contains (DNA, RNA etc...)
    # This is class is generating a fake barcode
    # We will use it when we are generating a new sanger barcode.
    module Lims::SupportApp
        class FakeBarcode
            def self.new_fake_barcode
                "1233334"
            end
        end
    end

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/barcodes", "{ \"barcode\": {\n    \"labware\": \"plate\",\n    \"role\": \"gel plate\",\n    \"contents\": \"blood\"\n}}\n"
    response.status.should == 400
    response.body.should match_json "{ \"general\": [\n    \"The request cannot be fulfilled due to bad parameter/syntax.\"\n  ]\n}\n"

  end
end
