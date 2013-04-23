require "integrations/requests/apiary/4_kit_resource/spec_helper"
describe "read_a_kit_object" do
  include_context "use core context service"
  it "read_a_kit_object" do
  # **Create a kit for an asset.**
  # 
  # * `process` the title of the specific process the kit relates to
  # * `aliquotType` the type of the aliquot the kit relates to
  # * `expires` the expiry date of the kit
  # * `amount` the amount of the kit

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/kits", "{ \"kit\": {\n    \"process\": \"DNA & RNA extraction\",\n    \"aliquot_type\": \"NA+P\",\n    \"expires\": \"2013-05-01\",\n    \"amount\": 10\n}}\n"
    response.status.should == 200
    response.body.should match_json "{ \"kit\": {\n    \"actions\": {\n        \"read\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"update\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"delete\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"create\": \"http://example.org/11111111-2222-3333-4444-555555555555\"\n    },\n    \"uuid\": \"11111111-2222-3333-4444-555555555555\",\n    \"process\": \"DNA & RNA extraction\",\n    \"aliquotType\": \"NA+P\",\n    \"expires\": \"2013-05-01\",\n    \"amount\": 10\n}}\n"

  end
end
