require "integrations/requests/apiary/4_kit_resource/spec_helper"
describe "read_a_kit_object", :kit => true do
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

    response = post "/kits", <<-EOD
    {
    "kit": {
        "process": "DNA & RNA extraction",
        "aliquot_type": "NA+P",
        "expires": "2013-05-01",
        "amount": 10
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "kit": {
        "actions": {
            "read": "http://example.org/11111111-2222-3333-4444-555555555555",
            "update": "http://example.org/11111111-2222-3333-4444-555555555555",
            "delete": "http://example.org/11111111-2222-3333-4444-555555555555",
            "create": "http://example.org/11111111-2222-3333-4444-555555555555"
        },
        "uuid": "11111111-2222-3333-4444-555555555555",
        "process": "DNA & RNA extraction",
        "aliquotType": "NA+P",
        "expires": "2013-05-01",
        "amount": 10
    }
}
    EOD

  end
end
