require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "use_the_create_printable_label_action", :barcode => true do
  include_context "use core context service"
  it "use_the_create_printable_label_action" do
  # **Use the create printable label action.**
  # * `template` the specific template to use to prin this label
  # * `ean13` the ean13 barcode to print
  # * `label_text` contains a list of labels with thear position to print

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/create_printable_label", <<-EOD
    {
    "create_printable_label": {
        "labels": [
            {
                "template": "tube",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "txt_1": "pos1",
                        "txt_3": "pos3"
                    }
                }
            }
        ]
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "create_printable_label": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": [
            {
                "template": "tube",
                "to_print": "D0430,0300,0400<new_line>AY;+08,0<new_line>AX;+022,+000,+00<new_line>T20C32<new_line>PC001;0112,0020,05,05,H,+02,11,B<new_line>PC002;0062,0020,05,05,H,+02,11,B<new_line>C<new_line>RC001;<printed by><new_line>RC002;<date><new_line>XS;I,0001,0002C5201<new_line>C<new_line>PC001;0038,0210,05,05,H,+03,11,B<new_line>PC002;0120,0210,05,05,H,+02,11,B<new_line>PC003;0070,0210,05,05,H,+02,11,B<new_line>PC005;0240,0165,05,1,G,+00,00,B<new_line>PC006;0220,0193,05,1,G,+00,00,B<new_line>PC007;0225,0217,05,1,G,+01,00,B<new_line>PC008;0150,0210,05,1,G,+01,11,B<new_line>XB01;0043,0100,5,3,01,0,0100,+0000000000,002,0,00<new_line>C<new_line>RC001;pos1<new_line>RC002;<new_line>RC003;pos3<new_line>RC005;<new_line>RC006;<new_line>RC007;<new_line>RC008;<new_line>RB01;274867088072<new_line>XS;I,0001,0002C3201<new_line>"
            }
        ],
        "labels": [
            {
                "template": "tube",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "txt_1": "pos1",
                        "txt_3": "pos3"
                    }
                }
            }
        ]
    }
}
    EOD

  end
end
