require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "use_the_create_barcode_action" do
  include_context "use core context service"
  it "use_the_create_barcode_action" do
  # **Use the create barcode action.**
  # * `labware` the specific labware the barcode relates to (tube, plate etc..)
  # * `role` the role of the labware (like 'stock')
  # * `contents` the type of the aliquot the labware contains (DNA, RNA etc...)

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/create_barcode", "{ \"create_barcode\": {\n    \"labware\": \"tube\",\n    \"role\": \"stock\",\n    \"contents\": \"DNA\"\n}}\n"
    puts response.body
    response.status.should == 200
    response.body.should match_json "{ \"create_barcode\": {\n    \"actions\": {\n    },\n    \"user\": \"user\",\n    \"application\": \"application\",\n    \"result\": {\n        \"barcode\": {\n            \"actions\": {\n                \"read\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n                \"update\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n                \"delete\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n                \"create\": \"http://example.org/11111111-2222-3333-4444-555555555555\"\n            },\n            \"uuid\": \"11111111-2222-3333-4444-555555555555\",\n            \"labware\": \"tube\",\n            \"role\": \"stock\",\n            \"contents\": \"DNA\"\n        },\n        \"ean13\": \"1234567891011\",\n        \"sanger\": {\n            \"prefix\": \"DN\",\n            \"number\": \"1234567\",\n            \"suffix\": \"K\"\n        }\n    },\n    \"labware\": \"tube\",\n    \"role\": \"stock\",\n    \"contents\": \"DNA\"\n}}\n"

  end
end
