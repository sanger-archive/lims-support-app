require "integrations/requests/apiary/4_kit_resource/spec_helper"
describe "add_a_label_to_a_kit" do
  include_context "use core context service"
  it "add_a_label_to_a_kit" do


  # **Use the create kit action.**
  # * `process` the title of the specific process the kit relates to
  # * `aliquotType` the type of the aliquot the kit relates to
  # * `expires` the expiry date of the kit
  # * `amount` the amount of the kit

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/create_kit", "{ \"create_kit\": {\n    \"process\": \"DNA & RNA extraction\",\n    \"aliquot_type\": \"NA+P\",\n    \"expires\": \"2013-05-01\",\n    \"amount\": 10\n}}\n"
    response.status.should == 200
    response.body.should match_json "{ \"create_kit\": {\n    \"actions\": {\n    },\n    \"user\": \"user\",\n    \"application\": \"application\",\n    \"result\": {\n        \"kit\": {\n            \"actions\": {\n                \"read\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n                \"update\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n                \"delete\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n                \"create\": \"http://example.org/11111111-2222-3333-4444-555555555555\"\n            },\n            \"uuid\": \"11111111-2222-3333-4444-555555555555\",\n            \"process\": \"DNA & RNA extraction\",\n            \"aliquotType\": \"NA+P\",\n            \"expires\": \"2013-05-01\",\n            \"amount\": 10\n        },\n        \"uuid\": \"11111111-2222-3333-4444-555555555555\"\n    },\n    \"process\": \"DNA & RNA extraction\",\n    \"aliquot_type\": \"NA+P\",\n    \"expires\": \"2013-05-01\",\n    \"amount\": 10\n}}\n"

  # **Add a label to an asset.**
  # 
  # * `name` unique identifier of an asset (for example: uuid of a plate)
  # * `type` type of the object the labellable related (resource, equipment, user etc...)
  # * `labels` it is a hash which contains the information of the labels.
  # By labels we mean any readable information found on a physical object.
  # Label can eventually be identified by a position: an arbitray string (not a Symbol).
  # It has a value, which can be serial number, stick label with barcode etc.
  # It has a type, which can be sanger-barcode, 2d-barcode, ean13-barcode etc...

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/labellables", "{ \"labellable\": {\n    \"name\": \"11111111-2222-3333-4444-555555555555\",\n    \"type\": \"resource\",\n    \"labels\": {\n        \"front barcode\": {\n            \"value\": \"1234567890123\",\n            \"type\": \"sanger-barcode\"\n        }\n    }\n}}\n"
    response.status.should == 200
    response.body.should match_json "{ \"labellable\": {\n    \"actions\": {\n        \"read\": \"http://example.org/11111111-2222-3333-4444-666666666666\",\n        \"update\": \"http://example.org/11111111-2222-3333-4444-666666666666\",\n        \"delete\": \"http://example.org/11111111-2222-3333-4444-666666666666\",\n        \"create\": \"http://example.org/11111111-2222-3333-4444-666666666666\"\n    },\n    \"uuid\": \"11111111-2222-3333-4444-666666666666\",\n    \"name\": \"11111111-2222-3333-4444-555555555555\",\n    \"type\": \"resource\",\n    \"labels\": {\n        \"front barcode\": {\n            \"value\": \"1234567890123\",\n            \"type\": \"sanger-barcode\"\n        }\n    }\n}}\n"

  # **Reads the previously created kit.**

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = get "/11111111-2222-3333-4444-555555555555", nil
    response.status.should == 200
    response.body.should match_json "{ \"kit\": {\n    \"actions\": {\n        \"read\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"update\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"delete\": \"http://example.org/11111111-2222-3333-4444-555555555555\",\n        \"create\": \"http://example.org/11111111-2222-3333-4444-555555555555\"\n    },\n    \"uuid\": \"11111111-2222-3333-4444-555555555555\",\n    \"process\": \"DNA & RNA extraction\",\n    \"aliquotType\": \"NA+P\",\n    \"expires\": \"2013-05-01\",\n    \"amount\": 10,\n    \"labels\": {\n        \"actions\": {\n            \"read\": \"http://example.org/11111111-2222-3333-4444-666666666666\",\n            \"create\": \"http://example.org/11111111-2222-3333-4444-666666666666\",\n            \"update\": \"http://example.org/11111111-2222-3333-4444-666666666666\",\n            \"delete\": \"http://example.org/11111111-2222-3333-4444-666666666666\"\n        },\n        \"uuid\": \"11111111-2222-3333-4444-666666666666\",\n        \"front barcode\": {\n            \"value\": \"1234567890123\",\n            \"type\": \"sanger-barcode\"\n        }\n    }\n}}\n"

  end
end
