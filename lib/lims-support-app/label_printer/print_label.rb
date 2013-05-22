require 'lims-core/actions/action'

require 'lims-support-app/label_printer/label_printer'
require 'lims-support-app/barcode/barcode'

require 'base64'

module Lims::SupportApp
  class LabelPrinter
    # This action validates if the barcodes are valid on the labels and also validates the
    # usable templates and if everything is OK, then physically prints the labels.
    class PrintLabel
      include Lims::Core::Actions::Action

      attribute :uuid, String, :required => true, :writer => :private, :initializable => true
      attribute :labels, Array, :required => true, :writer => :private, :initializable => true

      attr_reader :label_printer
      attr_reader :invalid_ean13_barcodes
      attr_reader :invalid_templates

      # specific characters
      ESC_CHARACTER = "\u001b" # every line's second character (exception: 1st line -> 1st character, no in the last line)
      NULL_CHARACTER = "\u0000" # every line starting with this character, but not the 1st one
      NEW_LINE_CHARACTER = "\n" # every line ending with this character

      def _call_in_session(session)
        @label_printer = session[uuid]
        @invalid_templates = []
        @invalid_ean13_barcodes = []

        # validates templates and barcodes
        validation

        # do the printing if everything is valid
        if @invalid_templates.empty? && @invalid_ean13_barcodes.empty?
          # process the labels
          labels.each do |label|
            # first load the proper template
            template_name = label["template"]
            label_template = template_to_fill(template_name)

            # fill in the template
            label_to_print = fill_the_templates(label_template, label)

            # print the label(s)
            print_labels(label_to_print)
          end
        end
        {:labels => labels}
      end

      def validation
        # validate templates
        validate_templates

        # validate barcodes
        validate_barcodes
      end

      def validate_templates
        valid_templates = []
        @label_printer.templates.each do |template|
          valid_templates << template["name"]
        end

        labels.each do |label|
          unless valid_templates.include?(label["template"])
            @invalid_templates << label["template"]
          end
        end
      end

      def validate_barcodes
        labels.each do |label|
          # validate the ean13_barcode(s)
          valid_main_ean13 = validate_ean13_barcode(label["main"]["ean13"])
          valid_dot_ean13 = label["dot"] && label["dot"]["ean13"] ? validate_ean13_barcode(label["dot"]["ean13"]) : true

          # gathering the invalid barcodes
          @invalid_ean13_barcodes << label["main"]["ean13"] unless valid_main_ean13
          @invalid_ean13_barcodes << label["dot"]["ean13"] if label["dot"] && label["dot"]["ean13"] && !valid_dot_ean13
        end
      end

      def validate_ean13_barcode(ean13)
        ean13.size == 13 && Barcode::calculate_ean13_checksum(ean13.chop) == ean13[ean13.size-1].to_i
      end
      private :validate_ean13_barcode

      def template_to_fill(name)
        @label_printer.templates.each do |template|
          return template["content"] if template["name"] == name
        end
      end

      def fill_the_templates(label_template, label)
        label_template = Base64.decode64(label_template)
        # replaces placeholders with barcode(s) 
        label_template.gsub!('<main_barcode>', label["main"]["ean13"].chop)
        label_template.gsub!('<dot_barcode>', label["dot"]["ean13"].chop) if label["dot"] && label["dot"]["ean13"]

        add_text_to_template(label_template, label["main"]["label_text"]) unless label["main"]["label_text"].empty?
        label_template
      end

      # Replaces the placeholders with the labels in the template.
      def add_text_to_template(label_template, label_text)
        (1...10).each do |i|
          key = "txt_#{i}"
          replace = label_text[key.to_s]
        label_template.gsub!("<#{key}>", replace == nil ? "" : replace)
        end
      end

      def print_labels(label_to_print)
        label_to_print = add_escape_characters(label_to_print)
        print_label(label_to_print)
      end
  
      # physically prints to the printer using the underlying print system
      def print_label(label_to_print)
        `lpr -l -P#{@label_printer.name} < #{label_to_print}`
      end
  
      private
      def add_escape_characters(label_to_print)
        # add specific escape characters to the label to print
        label_to_print = ESC_CHARACTER + label_to_print.chop!
        label_to_print.gsub!(
          NEW_LINE_CHARACTER,
          NEW_LINE_CHARACTER + NULL_CHARACTER + ESC_CHARACTER)
        label_to_print.chop! + NEW_LINE_CHARACTER
      end
    end
  end
end
