Rails.application.config.middleware.use Warden::Manager do |config|
  config.failure_app = ->(env) { SessionsController.action(:new).call(env) } # TODO: Fix me.

  config.default_scope = :session

  config.scope_defaults :session, store: false, strategies: [:jwt, :api_token]
end

# TODO: See here for how Devise initializes Warden: https://github.com/heartcombo/devise/blob/715192a7709a4c02127afb067e66230061b82cf2/lib/devise/rails.rb
#       It's also worth perusing the mention of 'warden' in the Devise repo. Interesting strategies at work.

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
                   iss: 'Helvellyn', verify_iss: true, algorithm: 'HS256' # [1]
    rescue JWT::InvalidIssuerError
      fail!('Could not authenticate')
    end

    session = Session.find(token[0]['data']['session_id'])

    session ? success!(session) : fail!('Could not authenticate')
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
    session = Session.find_by(token: env['HTTP_API_TOKEN'])
    session ? success!(session) : fail!('Could not authenticate')
  end

  def store?
    false
  end
end

# [1] Use of `secrets` instead of `credentials` makes for a container-ready deploy on Heroku (easier setup for open source)
#     Now that we've transitioned into an Engine, though, we should...
# TODO: Use credentials if credentials is present, use secrets if secrets is present.
#       Take a look at how devise achieves the same thing.
