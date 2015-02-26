require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "create_a_label_printer_and_update_it", :label_printer => true do
  include_context "use core context service"
  it "create_a_label_printer_and_update_it" do


  # **Use the create label printer action.**
  # 
  # * `name` the name of the label printer to use
  # * `templates` the list of templates to use with this printer
  # * `label_type` the type of the label in the printer
  # * `header` the header of the labels
  # * `footer` the footer of the labels

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
                "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQxfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQyfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQzfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ1fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ2fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ3fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwODt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ4fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQ=="
            }
        ],
        "label_type": "tube labels",
        "header": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDAyMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDAyMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7e3toZWFkZXJfdGV4dDF9fQpSQzAwMjt7e2hlYWRlcl90ZXh0Mn19ClhTO0ksMDAwMSwwMDAyQzUyMDEK",
        "footer": "UEMwMDE7MDExMiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDI7MDA2MiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpD"
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
                        "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQxfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQyfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQzfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ1fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ2fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ3fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwODt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ4fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQ=="
                    }
                ],
                "label_type": "tube labels",
                "header": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDAyMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDAyMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7e3toZWFkZXJfdGV4dDF9fQpSQzAwMjt7e2hlYWRlcl90ZXh0Mn19ClhTO0ksMDAwMSwwMDAyQzUyMDEK",
                "footer": "UEMwMDE7MDExMiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDI7MDA2MiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpD"
            },
            "uuid": "11111111-2222-3333-4444-555555555555"
        },
        "name": "e367bc",
        "templates": [
            {
                "name": "tube",
                "description": "normal tube template",
                "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQxfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQyfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQzfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ1fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ2fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ3fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwODt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ4fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQ=="
            }
        ],
        "label_type": "tube labels",
        "header": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDAyMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDAyMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7e3toZWFkZXJfdGV4dDF9fQpSQzAwMjt7e2hlYWRlcl90ZXh0Mn19ClhTO0ksMDAwMSwwMDAyQzUyMDEK",
        "footer": "UEMwMDE7MDExMiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDI7MDA2MiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpD"
    }
}
    EOD

  # **Using the update action on a label printer**
  # 
  # Update a label printer's following attributes:
  # * `templates` the array of the new templates to use with the label printer
  # * `label_type` the updated label type
  # * `header` the updated header
  # * `footer` the updated footer

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = put "/11111111-2222-3333-4444-555555555555", <<-EOD
    {
    "label_type": "tube labels 2",
    "header": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDAyMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDAyMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7e3toZWFkZXJfdGV4dDF9fS0tClJDMDAyO3t7aGVhZGVyX3RleHQyfX0tLQpYUztJLDAwMDEsMDAwMkM1MjAxCg==",
    "footer": "UEMwMDE7MDExMiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDI7MDA2MiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19LS0KUkMwMDI7e3tmb290ZXJfdGV4dDJ9fS0tClhTO0ksMDAwMSwwMDAyQzUyMDEKQw==",
    "templates": [
        {
            "name": "tube2",
            "description": "normal tube template 2",
            "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQxfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQyfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQzfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ1fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQ=="
        }
    ]
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
                "name": "tube2",
                "description": "normal tube template 2",
                "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKQwpSQzAwMTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQxfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMjt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQyfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwMzt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQzfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQzAwNTt7eyNtYWluLmxhYmVsX3RleHR9fXt7bWFpbi5sYWJlbF90ZXh0LnRleHQ1fX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQ=="
            }
        ],
        "label_type": "tube labels 2",
        "header": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDAyMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDAyMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7e3toZWFkZXJfdGV4dDF9fS0tClJDMDAyO3t7aGVhZGVyX3RleHQyfX0tLQpYUztJLDAwMDEsMDAwMkM1MjAxCg==",
        "footer": "UEMwMDE7MDExMiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDI7MDA2MiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19LS0KUkMwMDI7e3tmb290ZXJfdGV4dDJ9fS0tClhTO0ksMDAwMSwwMDAyQzUyMDEKQw=="
    }
}
    EOD

  end
end
