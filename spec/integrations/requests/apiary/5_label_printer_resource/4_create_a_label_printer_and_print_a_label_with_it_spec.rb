require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "create_a_label_printer_and_print_a_label_with_it", :label_printer => true do
  include_context "use core context service"
  it "create_a_label_printer_and_print_a_label_with_it" do


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

  # **Call the print action on the label printer.**
    # I have to stub the printing, because the string to print
    # contains null bytes.
    Lims::SupportApp::LabelPrinter::PrintLabel.any_instance.stub(:print_labels) do
      # TODO ke4
    end

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/print_label", <<-EOD
    {
    "print_label": {
        "uuid": "11111111-2222-3333-4444-555555555555",
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
    "print_label": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "uuid": "11111111-2222-3333-4444-555555555555",
        "result": {
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
        },
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
