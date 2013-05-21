require 'lims-core/resource'

module Lims::SupportApp
  # A template is representing a label template we use to print labels.
  # It has a name, a description, like "tube labels with dot for top",
  # and the template's content we want to use to print out the label.
  class LabelPrinter
    class Template

      include Lims::Core::Resource

      attribute :name, String, :required => true, :writer => :private, :initializable => true
      attribute :description, String, :required => true, :writer => :private, :initializable => true
      attribute :content, String, :required => true, :writer => :private, :initializable => true

    end
  end
end
