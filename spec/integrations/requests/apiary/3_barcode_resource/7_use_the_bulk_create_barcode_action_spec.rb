require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "use_the_bulk_create_barcode_action", :barcode => true do
  include_context "use core context service"
  it "use_the_bulk_create_barcode_action" do
  # **Use the bulk create barcode action.**
  # * `labware` the specific labware the barcode relates to (tube, plate etc..)
  # * `role` the role of the labware (like 'stock')
  # * `contents` the type of the aliquot the labware contains (DNA, RNA etc...)
  # * `number_of_barcodes` the number of the barcode(s) to create
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

    response = post "/actions/bulk_create_barcode", <<-EOD
    {
    "bulk_create_barcode": {
        "labware": "tube",
        "role": "stock",
        "contents": "DNA",
        "number_of_barcodes": 2
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "bulk_create_barcode": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": {
            "barcodes": [
                {
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
                {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-4444-666666666666",
                        "update": "http://example.org/11111111-2222-3333-4444-666666666666",
                        "delete": "http://example.org/11111111-2222-3333-4444-666666666666",
                        "create": "http://example.org/11111111-2222-3333-4444-666666666666"
                    },
                    "uuid": "11111111-2222-3333-4444-666666666666",
                    "ean13": "2741233334859",
                    "sanger": {
                        "prefix": "JD",
                        "number": "1233334",
                        "suffix": "U"
                    }
                }
            ]
        },
        "labware": "tube",
        "role": "stock",
        "contents": "DNA",
        "number_of_barcodes": 2
    }
}
    EOD

  end
end
