require 'lims-support-app/label_printer/label_printer'
require 'base64'

module Lims::SupportApp
  describe LabelPrinter do
    let(:printer_name) { "e367bc" }
    let(:template_type_tube) { "tube" }
    let(:template_description_tube) { "normal tube template" }
    let(:template_content_tube) {
      template = File.open(File.join('label_templates', 'tube_label_template.txt')) { |f| f.read }
      Base64.encode64(template).gsub(/\n/, '') # encodes then strips new line
    }
    let(:header) {
      template = File.open(File.join('label_templates', 'tube_header_template.txt')) { |f| f.read }
      Base64.encode64(template).gsub(/\n/, '') # encodes then strips new line
    }
    let(:footer) {
      template = File.open(File.join('label_templates', 'tube_footer_template.txt')) { |f| f.read }
      Base64.encode64(template).gsub(/\n/, '') # encodes then strips new line
    }
    let(:template_type_spin_column) { "spin_column" }
    let(:template_description_spin_column) { "normal spin_column template" }
    let(:template_content_spin_column) {
    }
    let(:label_type) { "normal tube_label" }
    let(:parameters) { 
      {
        "name" => printer_name,
        "templates" => [
          {
            "name" => template_type_tube,
            "description" => template_description_tube,
            "content" => template_content_tube
          }
        ],
        "label_type" => label_type,
        "header" => header,
        "footer" => footer
      }
    }

    context "invalid resource" do
      it "requires a printer name" do
        described_class.new(parameters - [:name]).valid?.should == false
      end

      it "requires templates" do
        described_class.new(parameters - [:templates]).valid?.should == false
      end

      it "each templates should have a name, description and content" do
        parameters["templates"].each do |template|
          template.has_key?("name").should == true
          template.has_key?("description").should == true
          template.has_key?("content").should == true
        end
      end

      it "requires the labels type" do
        described_class.new(parameters - [:label_type]).valid?.should == false
      end

      it "requires a header" do
        described_class.new(parameters - [:header]).valid?.should == false
      end

      it "requires a footer" do
        described_class.new(parameters - [:footer]).valid?.should == false
      end
    end
  end
end
