require "integrations/requests/apiary/4_kit_resource/spec_helper"
describe "list_actions_for_a_kit_resource" do
  include_context "use core context service"
  it "list_actions_for_a_kit_resource" do
  # **List actions for a kit resource.**
  # 
  # * `create` creates a new kit via HTTP POST request
  # * `read` currently returns the list of actions for a kit resource via HTTP GET request
  # * `first` lists the first kit resources in a page browsing system
  # * `last` lists the last kit resources in a page browsing system

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = get "/kits", nil
    response.status.should == 200
    response.body.should match_json "{ \"kits\": {\n    \"actions\": {\n        \"create\": \"http://example.org/kits\",\n        \"read\": \"http://example.org/kits\",\n        \"first\": \"http://example.org/kits/page=1\",\n        \"last\": \"http://example.org/kits/page=-1\"\n    }\n} }\n"

  end
end
