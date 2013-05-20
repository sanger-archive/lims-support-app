require "integrations/requests/apiary/3_barcode_resource/spec_helper"
describe "use_the_create_printable_label_action_with_invalid_barcode", :barcode => true do
  include_context "use core context service"
  it "use_the_create_printable_label_action_with_invalid_barcode" do
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
                    "ean13": "274867088071",
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
    response.status.should == 400
    response.body.should match_json <<-EOD
    {
    "general": [
        "The request cannot be fulfilled due to bad parameter/syntax."
    ]
}
    EOD

  end
end
