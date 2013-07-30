require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "test_case_insensitivity_in_create_barcode_action", :barcode => true do
  include_context "use core context service"
  it "test_case_insensitivity_in_create_barcode_action" do
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

    response = post "/actions/create_barcode", <<-EOD
    {
    "create_barcode": {
        "labware": "TuBe",
        "role": "stOcK",
        "contents": "dNa"
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "create_barcode": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": {
            "barcode": {
                "actions": {
                    "read": "http://example.org/11111111-2222-3333-4444-555555555555",
                    "update": "http://example.org/11111111-2222-3333-4444-555555555555",
                    "delete": "http://example.org/11111111-2222-3333-4444-555555555555",
                    "create": "http://example.org/11111111-2222-3333-4444-555555555555"
                },
                "uuid": "11111111-2222-3333-4444-555555555555",
                "ean13": "2741233334859",
                "sanger": {
                    "prefix": "JD",
                    "number": "1233334",
                    "suffix": "U"
                }
            },
            "uuid": "11111111-2222-3333-4444-555555555555"
        },
        "labware": "TuBe",
        "role": "stOcK",
        "contents": "dNa"
    }
}
    EOD

  end
end
