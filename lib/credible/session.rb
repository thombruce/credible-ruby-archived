module Credible
  module Session
    extend ActiveSupport::Concern

    included do
      attr_accessor :login

      belongs_to :user, optional: true

      has_secure_token

      def jwt
        payload = {
          data: jwt_data,
          iss: Rails.application.class.module_parent_name,
          iat: Time.now.to_i,
          exp: Time.now.to_i + 4 * 3600
        }
        JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256' # [1]
      end

      def refresh_token
        payload = {
          data: refresh_jwt_data,
          iss: Rails.application.class.module_parent_name,
          iat: Time.now.to_i,
          exp: Time.now.to_i + 14 * 24 * 3600
        }
        JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256' # [1]
      end
    end

    class_methods do
      def authenticate(params)
        user = ::User.authenticate(params)
        new(user: user)
      end  
    end

    private

    def jwt_data
      {
        session_id: id,
        user_id: user.id,
        user: {
          id: user.id,
          email: user.email
        }
      }
    end

    def refresh_token_data
      {
        session_id: id
      }
    end
  end
end

# [1] Use of `secrets` instead of `credentials` makes for a container-ready deploy on Heroku (easier setup for open source)
