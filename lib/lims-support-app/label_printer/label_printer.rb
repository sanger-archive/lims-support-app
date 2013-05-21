require 'lims-core/resource'

module Lims::SupportApp
  # A Label Printer is representing a physical printer we use to print labels.
  # It has a name, a type of labels on the roll, like "tube labels with dot for top",
  # a list of templates that are valid for the type of label the printer has.
  class LabelPrinter

    include Lims::Core::Resource

    attribute :name, String, :required => true, :writer => :private, :initializable => true
    attribute :templates, Array, :required => true, :reader => :private, :writer => :private, :initializable => true
    attribute :label_type, String, :required => true, :writer => :private, :initializable => true

    attr_reader :list_of_valid_templates

    # specific characters
    ESC_CHARACTER = "\u001b" # every line's second character (exception: 1st line -> 1st character, no in the last line)
    NULL_CHARACTER = "\u0000" # every line starting with this character, but not the 1st one
    NEW_LINE_CHARACTER = "\n" # every line ending with this character

    # InvalidTemplateError exception raised if one of the given template 
    # to print is not valid (the list of valid templates does not contain it).
    class InvalidTemplateError < StandardError
    end

    def validate_templates
      templates.each do |template|
        unless @list_of_valid_templates.include?(template["name"])
          raise InvalidTemplateError, "One of the given templates is not compatible with this printer."
          return false
        end
      end
      true
    end

    def print_labels
      labels.each do |label|
        label["to_print"] = add_escape_characters(label["to_print"])
        print_label(label["to_print"])
      end
    end

    # physically prints to the printer using the underlying print system
    def print_label(label)
      `lpr -l -P#{name} < #{label}`
    end

    private
    def add_escape_characters(label)
      # add specific escape characters to the label to print
      label = ESC_CHARACTER + label.chop!
      label.gsub!(
        "<new_line>",
        NEW_LINE_CHARACTER + NULL_CHARACTER + ESC_CHARACTER)
      label.chop! + NEW_LINE_CHARACTER
    end
  end
end
