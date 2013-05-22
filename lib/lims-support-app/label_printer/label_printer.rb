require 'lims-core/resource'

module Lims::SupportApp
  # A Label Printer is representing a physical printer we use to print labels.
  # It has a name, a type of labels on the roll, like "tube labels with dot for top",
  # a list of templates that are valid for the type of label the printer has.
  class LabelPrinter

    include Lims::Core::Resource

    attribute :name, String, :required => true, :writer => :private, :initializable => true
    attribute :templates, Array, :default => [], :required => true, :writer => :private, :initializable => true
    attribute :label_type, String, :required => true, :writer => :private, :initializable => true

  end
end
