# Credible

Credible was extracted from [thombruce/helvellyn](https://github.com/thombruce/helvellyn) and is still a work in progress. The goal is to provide JWT and API token based authentication using [Warden](https://github.com/wardencommunity/warden/) for Rails API applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'credible'
```

And then execute:
```bash
$ bundle
```

Mount Credible's authentication routes in your `config/routes.rb` file:

```ruby
Rails.application.routes.draw do
  mount Credible::Engine => "/auth"
end
```

Credible is a work in progress and requires a complicated setup for now. It was extracted from [thombruce/helvellyn](https://github.com/thombruce/helvellyn). You'll need to add models and configure them manually. In future, I'll had helpers to handle this for you.

## Add Models

To get Credible working, your app will need at least a User model and a Session model.

### User model

```bash
rails g model User email:string:uniq password_digest:string confirmation_token:token confirmed_at:datetime
```

```ruby
class User < ApplicationRecord
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

  def self.authenticate(params)
    user = find_by_login(params[:login])
    user&.authenticate(params[:password])
  end

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
```

### Session model

```bash
rails g model Session user:references token:token
```

```ruby
class Session < ApplicationRecord
  belongs_to :user

  has_secure_token

  def self.authenticate(params)
    user = User.authenticate(params)
    new(user: user)
  end

  def jwt
    payload = {
      data: jwt_data,
      iss: 'Helvellyn'
    }
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256' # [1]
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
end
```

## Contributing

Credible is not yet accepting contributions. Watch this space.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
