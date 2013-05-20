require 'lims-core/actions/action'

require 'lims-support-app/barcode/barcode'

module Lims::SupportApp
  class Barcode
    # This class creates a printable label with text and barcode in it.
    class CreatePrintableLabel
      include Lims::Core::Actions::Action

      attribute :labels, Array, :required => true, :writer => :private, :initializable => true

      attr_reader :invalid_ean13_barcodes

      def _call_in_session(session)
        print_config = YAML.load_file(File.join("config", "print.yml"))

        templates_to_print = []
        @invalid_ean13_barcodes = []
        labels.each do |label|
          # validate the ean13_barcode(s)
          valid_main_ean13 = validate_ean13_barcode(label["main"]["ean13"])
          valid_dot_ean13 = label["dot"] && label["dot"]["ean13"] ? validate_ean13_barcode(label["dot"]["ean13"]) : true
          unless (valid_main_ean13 && valid_dot_ean13)
            # sends a HTTP 400 ERROR RESPONSE (invalid parameter) if the barcode(s) is/are invalid
            @invalid_ean13_barcodes << label["main"]["ean13"] unless valid_main_ean13
            @invalid_ean13_barcodes << label["dot"]["ean13"] if label["dot"] && label["dot"]["ean13"] && !valid_dot_ean13
          else
            template = label["template"]
            label_template = load_template(print_config, template)

            # replaces placeholders with barcode(s) 
            label_template.gsub!('<main_barcode>', label["main"]["ean13"].chop)
            label_template.gsub!('<dot_barcode>', label["dot"]["ean13"].chop) if label["dot"] && label["dot"]["ean13"]

            add_text_to_template(label_template, label["main"]["label_text"]) unless label["main"]["label_text"].empty?

            templates_to_print << { "template" => template, "to_print" => label_template }
          end
        end

        templates_to_print
      end

      def load_template(print_config, template)
        File.open(File.join('config', 'print', print_config[template])) { |f| f.read }.gsub(/\n/, "<new_line>")
      end

      private
      def validate_ean13_barcode(ean13)
        ean13.size == 13 && Barcode::calculate_ean13_checksum(ean13.chop) == ean13[ean13.size-1].to_i
      end

      # Replaces the placeholders with the labels in the template.
      def add_text_to_template(template, label_text)
        (1...10).each do |i|
          key = "txt_#{i}"
          replace = label_text[key.to_s]
          template.gsub!("<#{key}>", replace == nil ? "" : replace)
        end
      end

      # This method is useful to test the created label to print
      # It prints the label to a file and you can forward it to a barcode printer
      # to print it. ( lpr -l -P#{printer_name} < #{label_to_print} )
      def print_label(template)
        # It is temporary print the result to a file
        File.open("tmp/print_barcode.txt", "wb") do |print_barcode|
          print_barcode.write(template)
        end
      end
    end
  end
end
