<h1 id="credible" align="center">Credible</h1>

<p align="center"><strong>Credible</strong> | <a href="https://github.com/thombruce/credible-demo">Demo Repo</a> | <a href="https://github.com/thombruce/helvellyn">Helvellyn</a></p>

<p align="center"><a href="https://www.patreon.com/thombruce"><img src="https://c5.patreon.com/external/logo/become_a_patron_button.png" alt="Become a Patron"></a></p>

<p align="center"><a href="https://rubygems.org/gems/credible"><img src="https://img.shields.io/gem/v/credible?logo=rubygems" alt="Gem"></a>
<a href="https://github.com/thombruce/credible/actions"><img src="https://img.shields.io/github/workflow/status/thombruce/credible/CI?logo=github" alt="GitHub Workflow Status"></a>
<a href="https://codecov.io/gh/thombruce/credible"><img src="https://img.shields.io/codecov/c/github/thombruce/credible?logo=codecov" alt="Codecov"></a>
<a href="https://github.com/thombruce/credible/issues"><img src="https://img.shields.io/github/issues-raw/thombruce/credible?logo=github" alt="GitHub issues"></a></p>

<p align="center"><a href="MIT-LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License"></a>
<a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/contributions-welcome-blue.svg" alt="Contributing"></a>
<a href="https://discord.gg/YMU87db"><img src="https://img.shields.io/discord/697123984231366716?color=7289da&label=chat&logo=discord" alt="Discord"></a></p>

<p align="center"><a href="CHANGELOG.md"><img src="https://img.shields.io/badge/Keep%20a%20Changelog-v1.1.0%20adopted-red.svg" alt="Changelog"></a>
<a href="CODE_OF_CONDUCT.md"><img src="https://img.shields.io/badge/Contributor%20Covenant-v1.4%20adopted-ff69b4.svg" alt="Contributor Covenant"></a></p>

<p align="center">Credible was extracted from <a href="https://github.com/thombruce/helvellyn">thombruce/helvellyn</a> and is still a work in progress. The goal is to provide JWT and API token based authentication using <a href="https://github.com/wardencommunity/warden/">Warden</a> for Rails API applications.</p>

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

And in your Application Controller, inherit from `Credible::ControllerConcern`:

```ruby
class ApplicationController < ActionController::Base
  include Credible::ControllerConcern
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
  include Credible::User
end
```

### Session model

```bash
rails g model Session user:references token:token
```

```ruby
class Session < ApplicationRecord
  include Credible::Session
end
```

## Calling the API

To sign up and create a new user, send params in the form `{ user: { email: 'email@example.com', password: 'Pa$$word123!' } }` to `auth/signup` as a `POST` request. On success, this will return `{ access_token: '...', refresh_token: '...' }` that can be used to persist the user's session.

To sign in a user, send params in the form `{ session: { login: 'email@example.com', password: 'Pa$$word123!' } }` to `auth/login` as a `POST` request. On success, this will return `{ access_token: '...', refresh_token: '...' }` that can be used to persist the user's session.

To sign out a user, send an empty request to `auth/signout` as a `DELETE` request. On success, this will return no content. It will destroy the session in the database and invalidate any existing tokens. Note: If you are using the access token to authenticate the user on a separate server, it will still remain valid until its expiry.

To refresh an access token, send params in the form `{ refresh_token: '...' }` to `auth/refresh` as a `POST` request. On success, this will return `{ access_token: '...', refresh_token: '...' }` that can be used to continue the user's session. Note: This will also invalidate the refresh token used to renew the tokens, and provide a new refresh token for next use.

> **Be careful**
>
> Credible is still a work in progress and these routes will be subject to change. I'm thinking about keeping them around as sort of a "classic" mode, but I feel like more resource-oriented routes are also desirable. For example, I want to add a `/tokens` endpoint in place of the existing `/refresh` enpoint, because _refresh what?_ It's just more semantically correct.

## Mailers

To user Credible's in-built mailers, you must set a hostname for your application. A suitable setting for this in `config/environments/development.rb` might be:

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

Your app will also be expected to accept and properly route requests for `[root URL]/confirm/[confirmation token]?email=[email]`. The `confirmation_token` and `email` params should be sent with an AJAX request to the Credible auth route.

For example, if you have Credible mounted as `mount Credible::Engine => "/auth"`, you would make a get request to `/auth/confirm/[confirmation token]?email=[email]`.

_This is a little complicated and not very user friendly. A future version will provide an engine_name to assist with Rails' URL helpers, as well as an in-built UI for handling these requests on your behalf._

## Contributing

Credible is not yet accepting contributions. Watch this space.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
