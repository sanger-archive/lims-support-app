require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "use_the_create_label_printer_action", :label_printer => true do
  include_context "use core context service"
  it "use_the_create_label_printer_action" do
  # **Use the create label printer action.**
  # 
  # * `name` the name of the label printer to use
  # * `templates` the list of templates to use with this printer
  # * `label_type` the type of the label in the printer

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/create_label_printer", <<-EOD
    {
    "create_label_printer": {
        "name": "e367bc",
        "templates": [
            {
                "name": "tube",
                "description": "normal tube template",
                "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDIwMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDIwMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7ClJDMDAyOwpYUztJLDAwMDEsMDAwMkM1MjAxCkMKUEMwMDE7MDAzOCwwMjEwLDA1LDA1LEgsKzAzLDExLEIKUEMwMDI7MDEyMCwwMjEwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDM7MDA3MCwwMjEwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDU7MDI0MCwwMTY1LDA1LDEsRywrMDAsMDAsQgpQQzAwNjswMjIwLDAxOTMsMDUsMSxHLCswMCwwMCxCClBDMDA3OzAyMjUsMDIxNywwNSwxLEcsKzAxLDAwLEIKUEMwMDg7MDE1MCwwMjEwLDA1LDEsRywrMDEsMTEsQgpYQjAxOzAwNDMsMDEwMCw1LDMsMDEsMCwwMTAwLCswMDAwMDAwMDAwLDAwMiwwLDAwCkMKUkMwMDE7PHR4dF8xPgpSQzAwMjs8dHh0XzI+ClJDMDAzOzx0eHRfMz4KUkMwMDU7PHR4dF81PgpSQzAwNjs8dHh0XzY+ClJDMDA3Ozx0eHRfNz4KUkMwMDg7PHR4dF84PgpSQjAxOzxtYWluX2JhcmNvZGU+ClhTO0ksMDAwMSwwMDAyQzMyMDEKCg=="
            }
        ],
        "label_type": "tube labels"
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "create_label_printer": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": {
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
                        "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDIwMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDIwMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7ClJDMDAyOwpYUztJLDAwMDEsMDAwMkM1MjAxCkMKUEMwMDE7MDAzOCwwMjEwLDA1LDA1LEgsKzAzLDExLEIKUEMwMDI7MDEyMCwwMjEwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDM7MDA3MCwwMjEwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDU7MDI0MCwwMTY1LDA1LDEsRywrMDAsMDAsQgpQQzAwNjswMjIwLDAxOTMsMDUsMSxHLCswMCwwMCxCClBDMDA3OzAyMjUsMDIxNywwNSwxLEcsKzAxLDAwLEIKUEMwMDg7MDE1MCwwMjEwLDA1LDEsRywrMDEsMTEsQgpYQjAxOzAwNDMsMDEwMCw1LDMsMDEsMCwwMTAwLCswMDAwMDAwMDAwLDAwMiwwLDAwCkMKUkMwMDE7PHR4dF8xPgpSQzAwMjs8dHh0XzI+ClJDMDAzOzx0eHRfMz4KUkMwMDU7PHR4dF81PgpSQzAwNjs8dHh0XzY+ClJDMDA3Ozx0eHRfNz4KUkMwMDg7PHR4dF84PgpSQjAxOzxtYWluX2JhcmNvZGU+ClhTO0ksMDAwMSwwMDAyQzMyMDEKCg=="
                    }
                ],
                "label_type": "tube labels"
            },
            "uuid": "11111111-2222-3333-4444-555555555555"
        },
        "name": "e367bc",
        "templates": [
            {
                "name": "tube",
                "description": "normal tube template",
                "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDIwMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDIwMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7ClJDMDAyOwpYUztJLDAwMDEsMDAwMkM1MjAxCkMKUEMwMDE7MDAzOCwwMjEwLDA1LDA1LEgsKzAzLDExLEIKUEMwMDI7MDEyMCwwMjEwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDM7MDA3MCwwMjEwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDU7MDI0MCwwMTY1LDA1LDEsRywrMDAsMDAsQgpQQzAwNjswMjIwLDAxOTMsMDUsMSxHLCswMCwwMCxCClBDMDA3OzAyMjUsMDIxNywwNSwxLEcsKzAxLDAwLEIKUEMwMDg7MDE1MCwwMjEwLDA1LDEsRywrMDEsMTEsQgpYQjAxOzAwNDMsMDEwMCw1LDMsMDEsMCwwMTAwLCswMDAwMDAwMDAwLDAwMiwwLDAwCkMKUkMwMDE7PHR4dF8xPgpSQzAwMjs8dHh0XzI+ClJDMDAzOzx0eHRfMz4KUkMwMDU7PHR4dF81PgpSQzAwNjs8dHh0XzY+ClJDMDA3Ozx0eHRfNz4KUkMwMDg7PHR4dF84PgpSQjAxOzxtYWluX2JhcmNvZGU+ClhTO0ksMDAwMSwwMDAyQzMyMDEKCg=="
            }
        ],
        "label_type": "tube labels"
    }
}
    EOD

  end
end
