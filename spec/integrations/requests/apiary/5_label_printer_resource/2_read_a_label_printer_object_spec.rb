require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "read_a_label_printer_object", :label_printer => true do
  include_context "use core context service"
  it "read_a_label_printer_object" do
  # **Use the create label printer action.**
  # 
  # * `name` the name of the label printer to use
  # * `templates` the list of templates to use with this printer
  # * `label_type` the type of the label in the printer

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/label_printers", <<-EOD
    {
    "label_printer": {
        "name": "e367bc",
        "templates": [
            {
                "name": "tube",
                "description": "normal tube template",
                "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyCnt7aGVhZGVyfX0KQwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7e3RleHQxfX0KUkMwMDI7e3t0ZXh0Mn19ClJDMDAzO3t7dGV4dDN9fQpSQzAwNTt7e3RleHQ1fX0KUkMwMDY7e3t0ZXh0Nn19ClJDMDA3O3t7dGV4dDd9fQpSQzAwODt7e3RleHQ4fX0KUkIwMTt7e21haW5fYmFyY29kZX19ClhTO0ksMDAwMSwwMDAyQzMyMDEKe3tmb290ZXJ9fQoK"
            }
        ],
        "label_type": "tube labels"
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "label_printer": {
        "actions": {
            "read": "http://example.org/11111111-2222-3333-4444-555555555555",
            "update": "http://example.org/11111111-2222-3333-4444-555555555555",
            "delete": "http://example.org/11111111-2222-3333-4444-555555555555",
            "create": "http://example.org/11111111-2222-3333-4444-555555555555"
        },
        "uuid": "11111111-2222-3333-4444-555555555555",
        "name": "e367bc",
        "templates": [
            {
                "name": "tube",
                "description": "normal tube template",
                "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyCnt7aGVhZGVyfX0KQwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7e3RleHQxfX0KUkMwMDI7e3t0ZXh0Mn19ClJDMDAzO3t7dGV4dDN9fQpSQzAwNTt7e3RleHQ1fX0KUkMwMDY7e3t0ZXh0Nn19ClJDMDA3O3t7dGV4dDd9fQpSQzAwODt7e3RleHQ4fX0KUkIwMTt7e21haW5fYmFyY29kZX19ClhTO0ksMDAwMSwwMDAyQzMyMDEKe3tmb290ZXJ9fQoK"
            }
        ],
        "label_type": "tube labels"
    }
}
    EOD

  end
end
