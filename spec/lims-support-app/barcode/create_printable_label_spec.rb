# Model requirements
require 'lims-support-app/barcode/barcode'
require 'lims-support-app/barcode/create_printable_label'
require 'lims-core/persistence/store'
require 'lims-support-app/spec_helper'

module Lims::SupportApp
  describe Barcode::CreatePrintableLabel do

    shared_examples_for "printing labels" do
      it_behaves_like "an action"

      it "prints labels" do
        result = subject.call
        result.should be_a(Array)
        print_config = YAML.load_file(File.join("config", "print.yml"))
        result.each do |print_element|
          template_name = print_element["template"]
          [template_tube, template_spin_column].should include(template_name)
          expected_to_print = File.open(File.join('spec', 'config', 'print', print_config[template_name])) { |f| f.read }.chop.gsub(/\n/, "<new_line>")
          print_element["to_print"].should == expected_to_print
        end
      end
    end

    include_context "for application", "label printing"
    let!(:store) { Lims::Core::Persistence::Store.new }
    let(:template_tube) { "tube" }
    let(:template_spin_column) { "spin_column" }
    let(:ean13_barcode_tube) { "2748670880727" }
    let(:ean13_barcode_spin_column1) { "2748746359751" }
    let(:ean13_barcode_spin_column2) { "2741854757853" }
    let(:label_text_tube) { { "txt_1" => "pos1", "txt_3" => "pos3"} }
    let(:label_text_spin_column) { { "txt_2" => "pos2", "txt_6" => "pos6"} }
    let(:parameters) { 
      {
        "labels" => [
          {
            "template" => template_tube,
            "main" => {
              "ean13" => ean13_barcode_tube,
              "label_text" => label_text_tube
            }
          },
          {
            "template" => template_spin_column,
            "main" => {
              "ean13" => ean13_barcode_spin_column1,
              "label_text" => label_text_spin_column
            },
            "dot" => {
              "ean13" => ean13_barcode_spin_column2,
            }
          }
        ]
      }
    }

    context "invalid action" do
      it "requires an ean13_barcode" do
        described_class.new(parameters - [:ean13_barcode]).valid?.should == false
      end

      it "requires a valid ean13 barcode" do
        described_class.new(parameters.merge({:ean13_barcode => "111"})).valid?.should == false
      end
    end

    context "valid action" do
      subject {
        described_class.new(:store => store, :user => user, :application => application) do |a,s|
          parameters.each do |k,v|
            a.send("#{k}=", v)
          end
        end
      }

      it_behaves_like "printing labels"
    end
  end
end