# Credible

[![Become a Patron](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/thombruce)

[![Gem](https://img.shields.io/gem/v/credible?logo=rubygems)](https://rubygems.org/gems/credible)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thombruce/credible/CI?logo=github)](https://github.com/thombruce/credible/actions)
[![Codecov](https://img.shields.io/codecov/c/github/thombruce/credible?logo=codecov)](https://codecov.io/gh/thombruce/credible)
[![GitHub issues](https://img.shields.io/github/issues-raw/thombruce/credible?logo=github)](https://github.com/thombruce/credible/issues)

[![License](https://img.shields.io/badge/license-MIT-green.svg)](MIT-LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
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

And in your Application Controller, inherit from `Credible::ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
  include Credible::ApplicationController
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

## Contributing

Credible is not yet accepting contributions. Watch this space.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
