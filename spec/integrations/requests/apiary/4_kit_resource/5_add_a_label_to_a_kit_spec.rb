require "integrations/requests/apiary/4_kit_resource/spec_helper"
describe "add_a_label_to_a_kit", :kit => true do
  include_context "use core context service"
  it "add_a_label_to_a_kit" do


  # **Use the create kit action.**
  # * `process` the title of the specific process the kit relates to
  # * `aliquotType` the type of the aliquot the kit relates to
  # * `expires` the expiry date of the kit
  # * `amount` the amount of the kit

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/create_kit", <<-EOD
    {
    "create_kit": {
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
    "create_kit": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": {
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
            },
            "uuid": "11111111-2222-3333-4444-555555555555"
        },
        "process": "DNA & RNA extraction",
        "aliquot_type": "NA+P",
        "expires": "2013-05-01",
        "amount": 10
    }
}
    EOD

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

    response = post "/labellables", <<-EOD
    {
    "labellable": {
        "name": "11111111-2222-3333-4444-555555555555",
        "type": "resource",
        "labels": {
            "front barcode": {
                "value": "1234567890123",
                "type": "sanger-barcode"
            }
        }
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "labellable": {
        "actions": {
            "read": "http://example.org/11111111-2222-3333-4444-666666666666",
            "update": "http://example.org/11111111-2222-3333-4444-666666666666",
            "delete": "http://example.org/11111111-2222-3333-4444-666666666666",
            "create": "http://example.org/11111111-2222-3333-4444-666666666666"
        },
        "uuid": "11111111-2222-3333-4444-666666666666",
        "name": "11111111-2222-3333-4444-555555555555",
        "type": "resource",
        "labels": {
            "front barcode": {
                "value": "1234567890123",
                "type": "sanger-barcode"
            }
        }
    }
}
    EOD

  # **Reads the previously created kit.**

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = get "/11111111-2222-3333-4444-555555555555"
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
        "amount": 10,
        "labels": {
            "actions": {
                "read": "http://example.org/11111111-2222-3333-4444-666666666666",
                "create": "http://example.org/11111111-2222-3333-4444-666666666666",
                "update": "http://example.org/11111111-2222-3333-4444-666666666666",
                "delete": "http://example.org/11111111-2222-3333-4444-666666666666"
            },
            "uuid": "11111111-2222-3333-4444-666666666666",
            "front barcode": {
                "value": "1234567890123",
                "type": "sanger-barcode"
            }
        }
    }
}
    EOD

  end
end
