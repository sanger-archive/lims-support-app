require "integrations/requests/apiary/spec_helper"
describe "root" do
  include_context "use core context service"
  it "root" do
  # --
  # Root
  # --
  # 
  # The root JSON lists all the resources available through the Lims Support Application and all the actions which can be performed. 
  # A resource responds to all the actions listed under its `actions` elements.
  # Consider this URL and the JSON response like the entry point for S2 Lims Support Application. All the other interactions through the 
  # Support App can be performed browsing this JSON response.

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = get "/", nil
    response.status.should == 200
    response.body.should match_json " {\n         \"actions\": {\n           \"actions\": {\n             \"create\": \"http://example.org/actions/action\"\n           }\n         },\n         \"uuid_resources\": {\n           \"actions\": {\n             \"create\": \"http://example.org/uuid_resources\",\n             \"read\": \"http://example.org/uuid_resources\",\n             \"first\": \"http://example.org/uuid_resources/page=1\",\n             \"last\": \"http://example.org/uuid_resources/page=-1\"\n           }\n         },\n         \"barcodes\": {\n           \"actions\": {\n             \"create\": \"http://example.org/barcodes\",\n             \"read\": \"http://example.org/barcodes\",\n             \"first\": \"http://example.org/barcodes/page=1\",\n             \"last\": \"http://example.org/barcodes/page=-1\"\n           }\n         },\n         \"kits\": {\n           \"actions\": {\n             \"create\": \"http://example.org/kits\",\n             \"read\": \"http://example.org/kits\",\n             \"first\": \"http://example.org/kits/page=1\",\n             \"last\": \"http://example.org/kits/page=-1\"\n           }\n         },\n         \"create_barcodes\": {\n           \"actions\": {\n             \"create\": \"http://example.org/actions/create_barcode\"\n           }\n         },\n         \"create_kits\": {\n           \"actions\": {\n             \"create\": \"http://example.org/actions/create_kit\"\n           }\n         },\n         \"revision\": 3\n       }\n"

  end
end
