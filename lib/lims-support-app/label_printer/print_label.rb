require 'lims-core/actions/action'

require 'lims-support-app/label_printer/label_printer'
require 'lims-support-app/barcode/barcode'

require 'base64'
require 'tempfile'
require 'mustache'

module Lims::SupportApp
  class LabelPrinter
    # This action validates if the barcodes are valid on the labels and also validates the
    # usable templates and if everything is OK, then physically prints the labels.
    class PrintLabel
      include Lims::Core::Actions::Action

      attribute :uuid, String, :required => true, :writer => :private, :initializable => true
      attribute :labels, Array, :required => true, :writer => :private, :initializable => true
      attribute :header_text, String, :required => true, :writer => :private, :initializable => true
      attribute :footer_text, String, :required => true, :writer => :private, :initializable => true

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
          labels_to_print = []
          labels_to_process = Marshal.load( Marshal.dump(labels))
          labels_to_process.each do |label|
            # first load the proper template
            template_name = label["template"]
            label_template = template_to_fill(template_name)

            # fill in the template
            ean13_code = label.deep_fetch_all("ean13").first

            print_count = print_count(session, ean13_code)
            if print_count
              if print_count > 0
                label["print_count"] = print_count + 1
              end
              increase_print_count(session, ean13_code)
            end

            label_to_print = fill_the_template(label_template, label)

            # add the specific escape characters for printing to the label
            labels_to_print << add_escape_characters(label_to_print)
          end

          # print the label(s)
          print_labels(labels_to_print)
        end
        {:labels => labels, :header_text => header_text, :footer_text => footer_text}
      end

      # physically prints to the printer using the underlying print system
      def print_labels(labels_to_print)
        add_header_and_footer(labels_to_print)

        temp_file = Tempfile.new('labels')
        begin
          temp_file.write(labels_to_print.join)
          temp_file.close

          `lpr -l -P#{@label_printer.name} < #{temp_file.path}`
        ensure
          temp_file.unlink # deletes the temp_file
        end
      end

      def add_header_and_footer(labels_to_print)
        labels_to_print.unshift(add_escape_characters(fill_the_template(@label_printer.header, header_text)))
        labels_to_print.push(add_escape_characters(fill_the_template(@label_printer.footer, footer_text)))
      end

      private
      def add_escape_characters(label_to_print)
        # add specific escape characters to the label to print
        label_to_print = ESC_CHARACTER + label_to_print
        label_to_print.gsub!(
          NEW_LINE_CHARACTER,
          NEW_LINE_CHARACTER + NULL_CHARACTER + ESC_CHARACTER)
        label_to_print + NEW_LINE_CHARACTER + NULL_CHARACTER
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
        @invalid_ean13_barcodes = labels.map {
          |label| label.deep_fetch_all("ean13") }.flatten.reject{ |ean13|
            send(:validate_ean13_barcode, ean13)
          }
      end

      def validate_ean13_barcode(ean13)
        ean13.size == 13 && Barcode::calculate_ean13_checksum(ean13.chop) == ean13[ean13.size-1].to_i
      end

      def template_to_fill(name)
        selected_template = @label_printer.templates.detect { |template| template["name"] == name }
        selected_template["content"] if selected_template
      end

      def fill_the_template(label_template, label_data)
        label_template = Base64.decode64(label_template)
        label_template = Mustache.render(label_template, chop_checksum_digit_from_barcodes(label_data))
      end

      def print_count(session, ean13_code)
        print_count = nil;
        barcode_record = session.database[:barcodes].select(:print_count).where(:ean13_code => ean13_code).first
        if barcode_record
          print_count = barcode_record[:print_count]
        end
        print_count
      end

      def increase_print_count(session, ean13_code)
        session.database[:barcodes].where(:ean13_code => ean13_code).update(:print_count => Sequel.expr(1) + :print_count)
      end

      def chop_checksum_digit_from_barcodes(label_data_to_process)
        label_data = {}
        label_data_to_process.each do |element_key, element_value|
          if element_key == "ean13"
            label_data["ean13_without_checksum"] = element_value.chop
            label_data[element_key] = element_value
          elsif element_value.is_a?(Hash)
            label_data[element_key] = chop_checksum_digit_from_barcodes(element_value)
          elsif element_value.is_a?(Array)
            label_data[element_key] = element_value.map(&method(:chop_checksum_digit_from_barcodes))
          else
            label_data[element_key] = element_value
          end
        end
        label_data
      end
    end

    Print = PrintLabel
  end
end
