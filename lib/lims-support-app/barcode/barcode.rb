require 'lims-core/resource'

require 'lims-support-app/barcode/prefix/barcode_prefixes'
require 'lims-support-app/barcode/prefix/labware_triple'
require 'lims-support-app/util/db_handler'

module Lims::SupportApp

  # A Barcode object is containing the sanger and ean13 type barcode
  # for a labware (like a tube, plate etc...).
  # It has the following parameters:
  # `labware` the specific labware the barcode relates to (tube, plate etc..)
  # `role` the role of the labware (like 'stock')
  # `contents` the type of the aliquot the labware contains (DNA, RNA etc...)
  class Barcode

    include Lims::Core::Resource

    attribute :labware, String, :required => true, :writer => :private, :initializable => true
    attribute :role, String, :required => true, :writer => :private, :initializable => true
    attribute :contents, String, :required => true, :writer => :private, :initializable => true
    attribute :ean13_code, String, :writer => :public, :initializable => true
    attribute :sanger_barcode_prefix, String, :required => true, :writer => :private, :initializable => true
    attribute :sanger_barcode, String, :required => true, :writer => :private, :initializable => true
    attribute :sanger_barcode_suffix, String, :required => true, :writer => :private, :initializable => true

  end
end
