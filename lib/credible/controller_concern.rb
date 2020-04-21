module Credible
  module ControllerConcern
    extend ActiveSupport::Concern

    included do
      skip_before_action :verify_authenticity_token

      before_action :authenticate!, if: proc { request.env['HTTP_AUTHORIZATION'] || request.env['HTTP_API_TOKEN'] }

      helper_method :current_user
      helper_method :current_session

      def current_user
        current_session.user
      end

      def current_session
        warden.user(:session) || ::Session.new(user: nil)
      end

      def warden
        request.env['warden']
      end

      def authenticate!
        warden.authenticate!
      end
    end

    class_methods do
    end
  end
end
