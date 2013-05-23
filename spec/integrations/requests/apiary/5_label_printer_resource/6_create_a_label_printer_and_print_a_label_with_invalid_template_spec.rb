require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "create_a_label_printer_and_print_a_label_with_invalid_template", :label_printer => true do
  include_context "use core context service"
  it "create_a_label_printer_and_print_a_label_with_invalid_template" do


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
                "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyCnt7aGVhZGVyfX0KQwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7e3RleHQxfX0KUkMwMDI7e3t0ZXh0Mn19ClJDMDAzO3t7dGV4dDN9fQpSQzAwNTt7e3RleHQ1fX0KUkMwMDY7e3t0ZXh0Nn19ClJDMDA3O3t7dGV4dDd9fQpSQzAwODt7e3RleHQ4fX0KUkIwMTt7e2VhbjEzfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQp7e2Zvb3Rlcn19Cg=="
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
                        "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyCnt7aGVhZGVyfX0KQwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7e3RleHQxfX0KUkMwMDI7e3t0ZXh0Mn19ClJDMDAzO3t7dGV4dDN9fQpSQzAwNTt7e3RleHQ1fX0KUkMwMDY7e3t0ZXh0Nn19ClJDMDA3O3t7dGV4dDd9fQpSQzAwODt7e3RleHQ4fX0KUkIwMTt7e2VhbjEzfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQp7e2Zvb3Rlcn19Cg=="
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
                "content": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyCnt7aGVhZGVyfX0KQwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7e3RleHQxfX0KUkMwMDI7e3t0ZXh0Mn19ClJDMDAzO3t7dGV4dDN9fQpSQzAwNTt7e3RleHQ1fX0KUkMwMDY7e3t0ZXh0Nn19ClJDMDA3O3t7dGV4dDd9fQpSQzAwODt7e3RleHQ4fX0KUkIwMTt7e2VhbjEzfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQp7e2Zvb3Rlcn19Cg=="
            }
        ],
        "label_type": "tube labels"
    }
}
    EOD

  # **Call the print action on the label printer.**
    # I have to stub the printing, because the string to print
    # contains a null byte.
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
                "template": "plate",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "text1": "pos1",
                        "text3": "pos3"
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
        "The request cannot be fulfilled due to bad parameter/syntax. The following template(s) are invalid: plate."
    ]
}
    EOD

  end
end
