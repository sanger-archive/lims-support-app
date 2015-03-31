require "integrations/requests/apiary/5_label_printer_resource/spec_helper"
describe "create_a_label_printer_and_print_a_tube_and_a_spin_column_label_with_it", :label_printer => true do
  include_context "use core context service"
  it "create_a_label_printer_and_print_a_tube_and_a_spin_column_label_with_it" do


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
            },
            {
                "name": "spin_column",
                "description": "normal spin column template",
                "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKWEIwMjswMzAwLDAxNDUsUSwyMCwwMywwNSwxCkMKUkMwMDE7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0MX19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDI7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0Mn19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDM7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0M319e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDU7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0NX19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDY7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0Nn19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDc7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0N319e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDg7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0OH19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkIwMTt7e21haW4uZWFuMTNfd2l0aG91dF9jaGVja3N1bX19ClJCMDI7e3tkb3QuZWFuMTN9fQpYUztJLDAwMDEsMDAwMkMzMjAxCg=="
            }
        ],
        "label_type": "tube and spin column labels",
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
                    },
                    {
                        "name": "spin_column",
                        "description": "normal spin column template",
                        "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKWEIwMjswMzAwLDAxNDUsUSwyMCwwMywwNSwxCkMKUkMwMDE7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0MX19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDI7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0Mn19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDM7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0M319e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDU7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0NX19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDY7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0Nn19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDc7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0N319e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDg7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0OH19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkIwMTt7e21haW4uZWFuMTNfd2l0aG91dF9jaGVja3N1bX19ClJCMDI7e3tkb3QuZWFuMTN9fQpYUztJLDAwMDEsMDAwMkMzMjAxCg=="
                    }
                ],
                "label_type": "tube and spin column labels",
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
            },
            {
                "name": "spin_column",
                "description": "normal spin column template",
                "content": "QwpQQzAwMTswMDM4LDAyMTAsMDUsMDUsSCwrMDMsMTEsQgpQQzAwMjswMTIwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwMzswMDcwLDAyMTAsMDUsMDUsSCwrMDIsMTEsQgpQQzAwNTswMjQwLDAxNjUsMDUsMSxHLCswMCwwMCxCClBDMDA2OzAyMjAsMDE5MywwNSwxLEcsKzAwLDAwLEIKUEMwMDc7MDIyNSwwMjE3LDA1LDEsRywrMDEsMDAsQgpQQzAwODswMTUwLDAyMTAsMDUsMSxHLCswMSwxMSxCClhCMDE7MDA0MywwMTAwLDUsMywwMSwwLDAxMDAsKzAwMDAwMDAwMDAsMDAyLDAsMDAKWEIwMjswMzAwLDAxNDUsUSwyMCwwMywwNSwxCkMKUkMwMDE7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0MX19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDI7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0Mn19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDM7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0M319e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDU7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0NX19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDY7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0Nn19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDc7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0N319e3svbWFpbi5sYWJlbF90ZXh0fX0KUkMwMDg7e3sjbWFpbi5sYWJlbF90ZXh0fX17e21haW4ubGFiZWxfdGV4dC50ZXh0OH19e3svbWFpbi5sYWJlbF90ZXh0fX0KUkIwMTt7e21haW4uZWFuMTNfd2l0aG91dF9jaGVja3N1bX19ClJCMDI7e3tkb3QuZWFuMTN9fQpYUztJLDAwMDEsMDAwMkMzMjAxCg=="
            }
        ],
        "label_type": "tube and spin column labels",
        "header": "RDA0MzAsMDMwMCwwNDAwCkFZOyswOCwwCkFYOyswMjIsKzAwMCwrMDAKVDIwQzMyClBDMDAxOzAxMTIsMDAyMCwwNSwwNSxILCswMiwxMSxCClBDMDAyOzAwNjIsMDAyMCwwNSwwNSxILCswMiwxMSxCCkMKUkMwMDE7e3toZWFkZXJfdGV4dDF9fQpSQzAwMjt7e2hlYWRlcl90ZXh0Mn19ClhTO0ksMDAwMSwwMDAyQzUyMDEK",
        "footer": "UEMwMDE7MDExMiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKUEMwMDI7MDA2MiwwMDIwLDA1LDA1LEgsKzAyLDExLEIKQwpSQzAwMTt7e2Zvb3Rlcl90ZXh0MX19ClJDMDAyO3t7Zm9vdGVyX3RleHQyfX0KWFM7SSwwMDAxLDAwMDJDNTIwMQpD"
    }
}
    EOD

  # **Call the print action on the label printer.**
    # I have to stub the printing, because the string to print
    # contains null bytes.
    Lims::SupportApp::LabelPrinter::PrintLabel.any_instance.stub(:print_labels) do
      # TODO ke4
    end
    
    barcode1 = Lims::SupportApp::Barcode.new(
      :labware  => 'tube',
      :role     => 'stock',
      :contents => 'Cell Pellet')
    
    barcode1.ean13_code = '2748670880727'
    
    barcode2 = Lims::SupportApp::Barcode.new(
      :labware  => 'tube',
      :role     => 'stock',
      :contents => 'Cell Pellet')
    
    barcode2.ean13_code = '2741854757853'
    
    barcode3 = Lims::SupportApp::Barcode.new(
      :labware  => 'tube',
      :role     => 'stock',
      :contents => 'Cell Pellet')
    
    barcode3.ean13_code = '2747595068692'
    
    save_with_uuid barcode1 => [1,2,3,4,7], barcode2 => [1,2,3,4,8], barcode3 => [1,2,3,4,9]

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
                        "text1": "pos1",
                        "text3": "pos3"
                    }
                }
            },
            {
                "template": "spin_column",
                "main": {
                    "ean13": "2741854757853",
                    "label_text": {
                        "text1": "sp1",
                        "text3": "sp2"
                    }
                },
                "dot": {
                    "ean13": "2747595068692"
                }
            }
        ],
        "header_text": {
            "header_text1": "header by ke4",
            "header_text2": "2014-11-04 14:26:02"
        },
        "footer_text": {
            "footer_text1": "footer by ke4",
            "footer_text2": "2014-11-04 14:26:02"
        }
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
                            "text1": "pos1",
                            "text3": "pos3"
                        }
                    }
                },
                {
                    "template": "spin_column",
                    "main": {
                        "ean13": "2741854757853",
                        "label_text": {
                            "text1": "sp1",
                            "text3": "sp2"
                        }
                    },
                    "dot": {
                        "ean13": "2747595068692"
                    }
                }
            ],
            "header_text": {
                "header_text1": "header by ke4",
                "header_text2": "2014-11-04 14:26:02"
            },
            "footer_text": {
                "footer_text1": "footer by ke4",
                "footer_text2": "2014-11-04 14:26:02"
            }
        },
        "labels": [
            {
                "template": "tube",
                "main": {
                    "ean13": "2748670880727",
                    "label_text": {
                        "text1": "pos1",
                        "text3": "pos3"
                    }
                }
            },
            {
                "template": "spin_column",
                "main": {
                    "ean13": "2741854757853",
                    "label_text": {
                        "text1": "sp1",
                        "text3": "sp2"
                    }
                },
                "dot": {
                    "ean13": "2747595068692"
                }
            }
        ],
        "header_text": {
            "header_text1": "header by ke4",
            "header_text2": "2014-11-04 14:26:02"
        },
        "footer_text": {
            "footer_text1": "footer by ke4",
            "footer_text2": "2014-11-04 14:26:02"
        }
    }
}
    EOD

  end
end
