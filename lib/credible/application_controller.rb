module Credible
  module ApplicationController
    extend ActiveSupport::Concern

    included do
      skip_before_action :verify_authenticity_token

      include Pundit
      after_action :verify_authorized
      after_action :verify_policy_scoped, only: :index

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from Pundit::NotDefinedError, with: :user_not_authorized

      before_action :authenticate!, if: proc { request.env['HTTP_AUTHORIZATION'] || request.env['HTTP_API_TOKEN'] }

      helper_method :current_user
      helper_method :current_session

      def pundit_user
        current_session
      end

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

    private

    def user_not_authorized
      render json: {}.to_json, status: :forbidden
    end
  end
end
