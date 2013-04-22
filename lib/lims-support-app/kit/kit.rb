require 'lims/core/resource'

module Lims::SupportApp
  class Kit

    include Lims::Core::Resource

    attribute :process, String, :required => true, :writer => :private, :initializable => true
    attribute :aliquot_type, String, :required => true, :writer => :private, :initializable => true
    attribute :expires, Date, :required => true, :writer => :private, :initializable => true
    attribute :amount, Fixnum, :required => true, :writer => :private, :initializable => true
  end
end
