require 'lims/core/resource'

module Lims::SupportApp
  class Kit

    include Lims::Core::Resource

    attribute :process, String, :required => true, :writer => :private, :initializable => true
    attribute :aliquot_type, String, :required => true, :writer => :private, :initializable => true
    attribute :expires, Date, :required => true, :writer => :private, :initializable => true
    attribute :amount, Fixnum, :required => true, :writer => :private, :initializable => true

    # InvalidKitError exception raised if a kit is not valid.
    # It can happen if the amount is less then 0 or the kit is expired.
    class InvalidKitError < StandardError
    end

    def usable?
      amount > 0
    end

    def decrease_amount(decrease_value = 1)
      @amount = @amount - decrease_value
      raise InvalidKitError, "The amount of kit can not be less then 1." unless amount > 0
      amount
    end
  end
end
