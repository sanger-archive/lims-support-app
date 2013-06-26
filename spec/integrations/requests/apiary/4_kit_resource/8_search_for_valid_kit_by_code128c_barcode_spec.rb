require "integrations/requests/apiary/4_kit_resource/spec_helper"
describe "search_for_valid_kit_by_code128c_barcode", :kit => true do
  include_context "use core context service"
  it "search_for_valid_kit_by_code128c_barcode" do


  # **Search for a valid kit by barcode**
  # 
  # * `description` describe the search
  # * `model` searched model (in our case: Kit)
  # * `criteria` set parameters for the search
  # * The Kit's expires field should be greater then or equal to current date and
  # * the Kit's amount field should be greater then 0
  # 
  # The search below returns kits with 
  # - expiry date gretaer or equals then 2013-04-24 and less then 2013-05-28
  # - and amount of kit is equals 10.
  # - and has a label with the following attributes:
  #   - position: front barcode
  #   - type: "code128-c-barcode",
  #   - value: "1234567890123"
  # 
  # To actually get the search results, you need to access the first page of result 
  # thanks to the `first` action in the JSON response.
    kit1 = Lims::SupportApp::Kit.new(:process => "DNA & RNA extraction",
      :aliquot_type => "NA+P",
      :expires => "2013-03-01",
      :amount => 10)
    labellable1 = Lims::LaboratoryApp::Labels::Labellable.new(:name => "11111111-2222-3333-4444-666666666666",
                                                        :type => "resource")
    label1 = Lims::LaboratoryApp::Labels::Labellable::Label.new(:type => "code128-c-barcode",
                                                          :value => "1234567890123456789012")
    labellable1["front barcode"] = label1
    
    kit2 = Lims::SupportApp::Kit.new(:process => "DNA & RNA extraction",
      :aliquot_type => "NA+P",
      :expires => "2013-07-01",
      :amount => 10)
    labellable2 = Lims::LaboratoryApp::Labels::Labellable.new(:name => "11111111-2222-3333-4444-777777777777",
                                                        :type => "resource")
    label2 = Lims::LaboratoryApp::Labels::Labellable::Label.new(:type => "code128-c-barcode",
                                                          :value => "1234567890123456789012")
    labellable2["front barcode"] = label2
    
    kit3 = Lims::SupportApp::Kit.new(:process => "DNA & RNA extraction",
      :aliquot_type => "NA+P",
      :expires => "2013-07-01",
      :amount => 15)
    labellable3 = Lims::LaboratoryApp::Labels::Labellable.new(:name => "11111111-2222-3333-4444-888888888888",
                                                        :type => "resource")
    label3 = Lims::LaboratoryApp::Labels::Labellable::Label.new(:type => "code128-c-barcode",
                                                          :value => "1234567890123456789022")
    labellable3["front barcode"] = label3
    
    save_with_uuid kit1 => [1,2,3,4,6], kit2 => [1,2,3,4,7], kit3 => [1,2,3,4,8], labellable1 => [1,2,3,4,1], labellable2 => [1,2,3,4,2], labellable3 => [1,2,3,4,3]

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/searches", <<-EOD
    {
    "search": {
        "description": "search for valid kit(s) by barcode",
        "model": "kit",
        "criteria": {
            "comparison": {
                "expires": {
                    ">=": "2013-04-24",
                    "<": "2013-07-28"
                },
                "amount": {
                    "=": 10
                }
            },
            "label": {
                "position": "front barcode",
                "type": "code128-c-barcode",
                "value": "1234567890123456789012"
            }
        }
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "search": {
        "actions": {
            "read": "http://example.org/11111111-2222-3333-4444-555555555555",
            "first": "http://example.org/11111111-2222-3333-4444-555555555555/page=1",
            "last": "http://example.org/11111111-2222-3333-4444-555555555555/page=-1"
        },
        "uuid": "11111111-2222-3333-4444-555555555555"
    }
}
    EOD

  # Get the search result

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = get "/11111111-2222-3333-4444-555555555555/page=1"
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "actions": {
        "read": "http://example.org/kits/page=1",
        "first": "http://example.org/kits/page=1",
        "last": "http://example.org/kits/page=-1"
    },
    "size": 1,
    "kits": [
        {
            "actions": {
                "read": "http://example.org/11111111-2222-3333-4444-777777777777",
                "create": "http://example.org/11111111-2222-3333-4444-777777777777",
                "update": "http://example.org/11111111-2222-3333-4444-777777777777",
                "delete": "http://example.org/11111111-2222-3333-4444-777777777777"
            },
            "uuid": "11111111-2222-3333-4444-777777777777",
            "process": "DNA & RNA extraction",
            "aliquotType": "NA+P",
            "expires": "2013-07-01",
            "amount": 10,
            "labels": {
                "actions": {
                    "read": "http://example.org/11111111-2222-3333-4444-222222222222",
                    "create": "http://example.org/11111111-2222-3333-4444-222222222222",
                    "update": "http://example.org/11111111-2222-3333-4444-222222222222",
                    "delete": "http://example.org/11111111-2222-3333-4444-222222222222"
                },
                "uuid": "11111111-2222-3333-4444-222222222222",
                "front barcode": {
                    "value": "1234567890123456789012",
                    "type": "code128-c-barcode"
                }
            }
        }
    ]
}
    EOD

  end
end
