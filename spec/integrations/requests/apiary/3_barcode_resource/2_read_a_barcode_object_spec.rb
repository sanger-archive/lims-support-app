require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "read_a_barcode_object" do
  include_context "use core context service"
  it "read_a_barcode_object" do
  # **Create a barcode for an asset.**
  # 
  # * `labware` the specific labware the barcode relates to (tube, plate etc..)
  # * `role` the role of the labware (like 'stock')
  # * `contents` the type of the aliquot the labware contains (DNA, RNA etc...)

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')


    response = post "/barcodes", "{ \"barcode\": {\n    \"labware\": \"tube\",\n    \"role\": \"stock\",\n    \"contents\": \"DNA\"\n}}\n"
    response.status.should == 200
    response.body.should match_json "{ \"barcode\": {\n    \"actions\": {\n        \"read\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"update\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"delete\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"create\": \"http://example.org/11111111-2222-3333-4444-555555555555\"\n    },\n    \"uuid\": \"11111111-2222-3333-4444-555555555555\",\n    \"labware\": \"tube\",\n    \"role\": \"stock\",\n    \"contents\": \"DNA\"\n}}\n"

  end
end
