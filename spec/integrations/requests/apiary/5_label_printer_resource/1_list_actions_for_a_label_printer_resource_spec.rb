require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "list_actions_for_a_label_printer_resource", :label_printer => true do
  include_context "use core context service"
  it "list_actions_for_a_label_printer_resource" do
  # **List actions for a label printer resource.**
  # 
  # * `create` creates a new label printer via HTTP POST request
  # * `read` currently returns the list of actions for a label printer resource via HTTP GET request
  # * `first` lists the first label printer resources in a page browsing system
  # * `last` lists the last label printer resources in a page browsing system

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = get "/label_printers"
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "label_printers": {
        "actions": {
            "create": "http://example.org/label_printers",
            "read": "http://example.org/label_printers",
            "first": "http://example.org/label_printers/page=1",
            "last": "http://example.org/label_printers/page=-1"
        }
    }
}
    EOD

  end
end
