require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "create_a_rack_label_printer_and_post_a_label_to_it", :label_printer => true do
  include_context "use core context service"
  it "create_a_rack_label_printer_and_post_a_label_to_it" do


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
        "name": "d304bc",
        "templates": [
            {
                "name": "rack",
                "description": "normal rack template",
                "content": "QwpQQzAwMTswMDMwLDAwMzUsMDUsMSxHLDAwLEIKUEMwMDI7MDAzMCwwMDY1LDA1LDEsRywwMCxCClBDMDAzOzA0NTAsMDAzNSwwNSwxLEcsMDAsQgpQQzAwNDswNDUwLDAwNjUsMDUsMSxHLDAwLEIKUEMwMDU7MDc1MCwwMDM1LDA1LDEsRywwMCxCClBDMDA2OzA3NTAsMDA2NSwwNSwxLEcsMDAsQgpQQzAwNzswNTA1LDAwMzUsMDUsMSxHLCswMywwMCxCClBDMDA4OzA1MDUsMDA2NSwwNSwxLEcsKzAzLDAwLEIKUEMwMDk7MDc1MCwwMDM1LDA1LDEsRywrMDMsMDAsQgpQQzAxMDswNzUwLDAwNjUsMDUsMSxHLCswMywwMCxCClBDMDEyOzAwNDAsMDA2NSwwNSwxLEcsMDAsQgpQQzAxMTswOTEwLDAwNjUsMDUsMSxHLCswMywzMyxXClBDMDEzOzAwMDgsMDAyMCwwNSwxLEcsKzAzLDExLFcKWEIwMTswMzAwLDAwMDAsNSwzLDAxLDAsMDA3MCwrMDAwMDAwMDAwMCwwMDIsMCwwMApDClJDMDAxO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDF9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAyO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDJ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAzO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDN9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA0O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDR9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA1O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDV9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA2O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDZ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDExO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDExfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQo="
            },
            {
                "name": "plate_96",
                "description": "normal plate template",
                "content": "QwpQQzAwMTswMDMwLDAwMzUsMDUsMSxHLDAwLEIKUEMwMDI7MDAzMCwwMDY1LDA1LDEsRywwMCxCClBDMDAzOzA0NTAsMDAzNSwwNSwxLEcsMDAsQgpQQzAwNDswNDUwLDAwNjUsMDUsMSxHLDAwLEIKUEMwMDU7MDc1MCwwMDM1LDA1LDEsRywwMCxCClBDMDA2OzA3NTAsMDA2NSwwNSwxLEcsMDAsQgpQQzAwNzswNTA1LDAwMzUsMDUsMSxHLCswMywwMCxCClBDMDA4OzA1MDUsMDA2NSwwNSwxLEcsKzAzLDAwLEIKUEMwMDk7MDc1MCwwMDM1LDA1LDEsRywrMDMsMDAsQgpQQzAxMDswNzUwLDAwNjUsMDUsMSxHLCswMywwMCxCClBDMDEyOzAwNDAsMDA2NSwwNSwxLEcsMDAsQgpQQzAxMTswOTEwLDAwNjUsMDUsMSxHLCswMywzMyxXClBDMDEzOzAwMDgsMDAyMCwwNSwxLEcsKzAzLDExLFcKWEIwMTswMjAwLDAwMDAsNSwzLDAyLDAsMDA3MCwrMDAwMDAwMDAwMCwwMDIsMCwwMApDClJDMDAxO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDF9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAyO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDJ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAzO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDN9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA0O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDR9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA1O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDV9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA2O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDZ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDExO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDExfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQo="
            }
        ],
        "label_type": "rack, plate labels",
        "header": "UEMwMDE7MDAyMCwwMDM1LDEsMSxHLDAwLEIKUEMwMDI7MDAyMCwwMDY1LDEsMSxHLDAwLEIKQwpSQzAwMTt7e2hlYWRlcl90ZXh0MX19ClJDMDAyO3t7aGVhZGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQ==",
        "footer": "UEMwMDE7MDA1MCwwMDM1LDEsMSxHLDAwLEIKUEMwMDI7MDAyMCwwMDY1LDEsMSxHLDAwLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpDCg=="
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
                "name": "d304bc",
                "templates": [
                    {
                        "name": "rack",
                        "description": "normal rack template",
                        "content": "QwpQQzAwMTswMDMwLDAwMzUsMDUsMSxHLDAwLEIKUEMwMDI7MDAzMCwwMDY1LDA1LDEsRywwMCxCClBDMDAzOzA0NTAsMDAzNSwwNSwxLEcsMDAsQgpQQzAwNDswNDUwLDAwNjUsMDUsMSxHLDAwLEIKUEMwMDU7MDc1MCwwMDM1LDA1LDEsRywwMCxCClBDMDA2OzA3NTAsMDA2NSwwNSwxLEcsMDAsQgpQQzAwNzswNTA1LDAwMzUsMDUsMSxHLCswMywwMCxCClBDMDA4OzA1MDUsMDA2NSwwNSwxLEcsKzAzLDAwLEIKUEMwMDk7MDc1MCwwMDM1LDA1LDEsRywrMDMsMDAsQgpQQzAxMDswNzUwLDAwNjUsMDUsMSxHLCswMywwMCxCClBDMDEyOzAwNDAsMDA2NSwwNSwxLEcsMDAsQgpQQzAxMTswOTEwLDAwNjUsMDUsMSxHLCswMywzMyxXClBDMDEzOzAwMDgsMDAyMCwwNSwxLEcsKzAzLDExLFcKWEIwMTswMzAwLDAwMDAsNSwzLDAxLDAsMDA3MCwrMDAwMDAwMDAwMCwwMDIsMCwwMApDClJDMDAxO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDF9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAyO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDJ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAzO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDN9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA0O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDR9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA1O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDV9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA2O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDZ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDExO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDExfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQo="
                    },
                    {
                        "name": "plate_96",
                        "description": "normal plate template",
                        "content": "QwpQQzAwMTswMDMwLDAwMzUsMDUsMSxHLDAwLEIKUEMwMDI7MDAzMCwwMDY1LDA1LDEsRywwMCxCClBDMDAzOzA0NTAsMDAzNSwwNSwxLEcsMDAsQgpQQzAwNDswNDUwLDAwNjUsMDUsMSxHLDAwLEIKUEMwMDU7MDc1MCwwMDM1LDA1LDEsRywwMCxCClBDMDA2OzA3NTAsMDA2NSwwNSwxLEcsMDAsQgpQQzAwNzswNTA1LDAwMzUsMDUsMSxHLCswMywwMCxCClBDMDA4OzA1MDUsMDA2NSwwNSwxLEcsKzAzLDAwLEIKUEMwMDk7MDc1MCwwMDM1LDA1LDEsRywrMDMsMDAsQgpQQzAxMDswNzUwLDAwNjUsMDUsMSxHLCswMywwMCxCClBDMDEyOzAwNDAsMDA2NSwwNSwxLEcsMDAsQgpQQzAxMTswOTEwLDAwNjUsMDUsMSxHLCswMywzMyxXClBDMDEzOzAwMDgsMDAyMCwwNSwxLEcsKzAzLDExLFcKWEIwMTswMjAwLDAwMDAsNSwzLDAyLDAsMDA3MCwrMDAwMDAwMDAwMCwwMDIsMCwwMApDClJDMDAxO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDF9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAyO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDJ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAzO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDN9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA0O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDR9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA1O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDV9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA2O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDZ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDExO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDExfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQo="
                    }
                ],
                "label_type": "rack, plate labels",
                "header": "UEMwMDE7MDAyMCwwMDM1LDEsMSxHLDAwLEIKUEMwMDI7MDAyMCwwMDY1LDEsMSxHLDAwLEIKQwpSQzAwMTt7e2hlYWRlcl90ZXh0MX19ClJDMDAyO3t7aGVhZGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQ==",
                "footer": "UEMwMDE7MDA1MCwwMDM1LDEsMSxHLDAwLEIKUEMwMDI7MDAyMCwwMDY1LDEsMSxHLDAwLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpDCg=="
            },
            "uuid": "11111111-2222-3333-4444-555555555555"
        },
        "name": "d304bc",
        "templates": [
            {
                "name": "rack",
                "description": "normal rack template",
                "content": "QwpQQzAwMTswMDMwLDAwMzUsMDUsMSxHLDAwLEIKUEMwMDI7MDAzMCwwMDY1LDA1LDEsRywwMCxCClBDMDAzOzA0NTAsMDAzNSwwNSwxLEcsMDAsQgpQQzAwNDswNDUwLDAwNjUsMDUsMSxHLDAwLEIKUEMwMDU7MDc1MCwwMDM1LDA1LDEsRywwMCxCClBDMDA2OzA3NTAsMDA2NSwwNSwxLEcsMDAsQgpQQzAwNzswNTA1LDAwMzUsMDUsMSxHLCswMywwMCxCClBDMDA4OzA1MDUsMDA2NSwwNSwxLEcsKzAzLDAwLEIKUEMwMDk7MDc1MCwwMDM1LDA1LDEsRywrMDMsMDAsQgpQQzAxMDswNzUwLDAwNjUsMDUsMSxHLCswMywwMCxCClBDMDEyOzAwNDAsMDA2NSwwNSwxLEcsMDAsQgpQQzAxMTswOTEwLDAwNjUsMDUsMSxHLCswMywzMyxXClBDMDEzOzAwMDgsMDAyMCwwNSwxLEcsKzAzLDExLFcKWEIwMTswMzAwLDAwMDAsNSwzLDAxLDAsMDA3MCwrMDAwMDAwMDAwMCwwMDIsMCwwMApDClJDMDAxO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDF9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAyO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDJ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAzO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDN9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA0O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDR9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA1O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDV9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA2O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDZ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDExO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDExfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQo="
            },
            {
                "name": "plate_96",
                "description": "normal plate template",
                "content": "QwpQQzAwMTswMDMwLDAwMzUsMDUsMSxHLDAwLEIKUEMwMDI7MDAzMCwwMDY1LDA1LDEsRywwMCxCClBDMDAzOzA0NTAsMDAzNSwwNSwxLEcsMDAsQgpQQzAwNDswNDUwLDAwNjUsMDUsMSxHLDAwLEIKUEMwMDU7MDc1MCwwMDM1LDA1LDEsRywwMCxCClBDMDA2OzA3NTAsMDA2NSwwNSwxLEcsMDAsQgpQQzAwNzswNTA1LDAwMzUsMDUsMSxHLCswMywwMCxCClBDMDA4OzA1MDUsMDA2NSwwNSwxLEcsKzAzLDAwLEIKUEMwMDk7MDc1MCwwMDM1LDA1LDEsRywrMDMsMDAsQgpQQzAxMDswNzUwLDAwNjUsMDUsMSxHLCswMywwMCxCClBDMDEyOzAwNDAsMDA2NSwwNSwxLEcsMDAsQgpQQzAxMTswOTEwLDAwNjUsMDUsMSxHLCswMywzMyxXClBDMDEzOzAwMDgsMDAyMCwwNSwxLEcsKzAzLDExLFcKWEIwMTswMjAwLDAwMDAsNSwzLDAyLDAsMDA3MCwrMDAwMDAwMDAwMCwwMDIsMCwwMApDClJDMDAxO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDF9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAyO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDJ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDAzO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDN9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA0O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDR9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA1O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDV9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDA2O3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDZ9fXt7L21haW4ubGFiZWxfdGV4dH19ClJDMDExO3t7I21haW4ubGFiZWxfdGV4dH19e3ttYWluLmxhYmVsX3RleHQudGV4dDExfX17ey9tYWluLmxhYmVsX3RleHR9fQpSQjAxO3t7bWFpbi5lYW4xM193aXRob3V0X2NoZWNrc3VtfX0KWFM7SSwwMDAxLDAwMDJDMzIwMQo="
            }
        ],
        "label_type": "rack, plate labels",
        "header": "UEMwMDE7MDAyMCwwMDM1LDEsMSxHLDAwLEIKUEMwMDI7MDAyMCwwMDY1LDEsMSxHLDAwLEIKQwpSQzAwMTt7e2hlYWRlcl90ZXh0MX19ClJDMDAyO3t7aGVhZGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQ==",
        "footer": "UEMwMDE7MDA1MCwwMDM1LDEsMSxHLDAwLEIKUEMwMDI7MDAyMCwwMDY1LDEsMSxHLDAwLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpDCg=="
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

    response = post "/11111111-2222-3333-4444-555555555555", <<-EOD
    {
    "label_printer": {
        "labels": [
            {
                "template": "plate_96",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "text1": "pos1",
                        "text3": "pos3"
                    }
                }
            },
            {
                "template": "rack",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "text1": "rack",
                        "text3": "pos3"
                    }
                }
            }
        ],
        "header_text": {
            "header_text1": "header by ke4",
            "header_text2": "2013-06-24 11:09:04"
        },
        "footer_text": {
            "footer_text1": "footer by ke4",
            "footer_text2": "2013-06-24 11:09:04"
        }
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "label_printer": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "uuid": "11111111-2222-3333-4444-555555555555",
        "result": {
            "labels": [
                {
                    "template": "plate_96",
                    "main": {
                        "ean13": "2748670880727",
                        "label_text": {
                            "text1": "pos1",
                            "text3": "pos3"
                        }
                    }
                },
                {
                    "template": "rack",
                    "main": {
                        "ean13": "2748670880727",
                        "label_text": {
                            "text1": "rack",
                            "text3": "pos3"
                        }
                    }
                }
            ],
            "header_text": {
                "header_text1": "header by ke4",
                "header_text2": "2013-06-24 11:09:04"
            },
            "footer_text": {
                "footer_text1": "footer by ke4",
                "footer_text2": "2013-06-24 11:09:04"
            }
        },
        "labels": [
            {
                "template": "plate_96",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "text1": "pos1",
                        "text3": "pos3"
                    }
                }
            },
            {
                "template": "rack",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "text1": "rack",
                        "text3": "pos3"
                    }
                }
            }
        ],
        "header_text": {
            "header_text1": "header by ke4",
            "header_text2": "2013-06-24 11:09:04"
        },
        "footer_text": {
            "footer_text1": "footer by ke4",
            "footer_text2": "2013-06-24 11:09:04"
        }
    }
}
    EOD

  end
end
