module Credible
  module User
    extend ActiveSupport::Concern

    included do
      has_secure_password validations: false
      has_secure_token :confirmation_token

      has_many :sessions, dependent: :destroy

      validates :email, presence: true
      validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

      # Custom password validation
      validate do |record|
        record.errors.add(:password, :blank) unless record.password_digest.present? || record.confirmation_token.present?
      end

      validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
      validates_confirmation_of :password, allow_blank: true
      # End custom password validation

      def confirm
        self.confirmation_token = nil
        self.password = SecureRandom.hex(8) unless password_digest.present?
        self.confirmed_at = Time.now.utc
      end

      def confirmed?
        confirmed_at.present?
      end

      def reset_password
        self.password_digest = nil
        self.confirmed_at = nil
        regenerate_confirmation_token
      end
    end

    class_methods do
      def find_by_login(login)
        find_by(email: login)
      end

      def authenticate(params)
        user = find_by_login(params[:login])
        user&.authenticate(params[:password])
      end
    end
  end
end
