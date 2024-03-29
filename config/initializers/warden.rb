Rails.application.config.middleware.use Warden::Manager do |config|
  config.failure_app = ->(env) { Credible::SessionsController.action(:fail).call(env) }

  config.default_scope = :session

  config.scope_defaults :session, store: false, strategies: [:jwt, :refresh, :api_token]
end

# TODO: See here for how Devise initializes Warden: https://github.com/heartcombo/devise/blob/715192a7709a4c02127afb067e66230061b82cf2/lib/devise/rails.rb
#       It's also worth perusing the mention of 'warden' in the Devise repo. Interesting strategies at work.

# TODO: Change to :access_token, maybe maintain :jwt as alias
Warden::Strategies.add(:jwt) do
  def valid?
    env['HTTP_AUTHORIZATION']
  end

  def env
    request.env
  end

  def authenticate!
    begin
      pattern = /^Bearer /
      header = env['HTTP_AUTHORIZATION']
      jwt = header.gsub(pattern, '') if header && header.match(pattern)
      token =
        JWT.decode jwt, Rails.application.secrets.secret_key_base, true,
                   iss: Rails.application.class.module_parent_name, 
                   verify_iss: true, verify_iat: true, verify_expiration: true,
                   algorithm: 'HS256' # [1]
    rescue JWT::InvalidIssuerError, JWT::InvalidIatError, JWT::ExpiredSignature
      fail!('Could not authenticate')
    end

    user = ::User.find(token[0]['data']['user_id'])
    session = ::Session.new(user: user)
    success!(session)
  rescue # ActiveRecord::RecordNotFound
    fail!('Could not authenticate')
  end

  def store?
    false
  end
end

Warden::Strategies.add(:refresh) do
  def valid?
    # params[:refresh_token]
    env['action_dispatch.request.parameters']['refresh_token'] # https://github.com/wardencommunity/warden/issues/84
  end

  def env
    request.env
  end

  def authenticate!
    begin
      jwt = env['action_dispatch.request.parameters']['refresh_token']
      token =
        JWT.decode jwt, Rails.application.secrets.secret_key_base, true,
                   iss: Rails.application.class.module_parent_name, 
                   verify_iss: true, verify_iat: true, verify_expiration: true,
                   algorithm: 'HS256' # [1]
    rescue JWT::InvalidIssuerError, JWT::InvalidIatError, JWT::ExpiredSignature
      fail!('Could not authenticate')
    end

    session = ::Session.find(token[0]['data']['session_id'])
    success!(session)
  rescue # ActiveRecord::RecordNotFound
    fail!('Could not authenticate')
  end

  def store?
    false
  end
end

Warden::Strategies.add(:api_token) do
  def valid?
    request.env['HTTP_API_TOKEN']
  end

  def env
    request.env
  end

  def authenticate!
    session = ::Session.find_by!(token: env['HTTP_API_TOKEN'])
    success!(session)
  rescue ActiveRecord::RecordNotFound
    fail!('Could not authenticate')
  end

  def store?
    false
  end
end

# [1] Use of `secrets` instead of `credentials` makes for a container-ready deploy on Heroku (easier setup for open source)
#     Now that we've transitioned into an Engine, though, we should...
# TODO: Use credentials if credentials is present, use secrets if secrets is present.
#       Take a look at how devise achieves the same thing.
