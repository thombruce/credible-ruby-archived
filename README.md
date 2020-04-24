# Credible

**Credible** | [Demo Repo](https://github.com/thombruce/credible-demo) | [Helvellyn](https://github.com/thombruce/helvellyn)

[![Become a Patron](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/thombruce)

[![Gem](https://img.shields.io/gem/v/credible?logo=rubygems)](https://rubygems.org/gems/credible)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thombruce/credible/CI?logo=github)](https://github.com/thombruce/credible/actions)
[![Codecov](https://img.shields.io/codecov/c/github/thombruce/credible?logo=codecov)](https://codecov.io/gh/thombruce/credible)
[![GitHub issues](https://img.shields.io/github/issues-raw/thombruce/credible?logo=github)](https://github.com/thombruce/credible/issues)

[![License](https://img.shields.io/badge/license-MIT-green.svg)](MIT-LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v1.4%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![Contributing](https://img.shields.io/badge/contributions-welcome-blue.svg)](CONTRIBUTING.md)
[![Discord](https://img.shields.io/discord/697123984231366716?color=7289da&label=chat&logo=discord)](https://discord.gg/YMU87db)

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
