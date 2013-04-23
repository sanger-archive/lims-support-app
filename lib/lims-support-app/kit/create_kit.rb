require 'lims/core/actions/action'

require 'lims-support-app/kit/kit'

module Lims::SupportApp
  class Kit
    class CreateKit
      include Lims::Core::Actions::Action

      attribute :process, String, :required => true, :writer => :private
      attribute :aliquot_type, String, :required => true, :writer => :private
      attribute :expires, Date, :required => true, :writer => :private
      attribute :amount, Fixnum, :required => true, :writer => :private

      def _call_in_session(session)
        kit = Kit.new(:process => process, :aliquot_type => aliquot_type,
          :expires => expires, :amount => amount)

        session << kit

        { :kit => kit, :uuid => session.uuid_for!(kit) }
      end
    end
  end

  class Kit
    Create = CreateKit
  end
end
