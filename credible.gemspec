$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "credible/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "credible"
  spec.version     = Credible::VERSION
  spec.authors     = ["Thom Bruce"]
  spec.email       = ["thom@thombruce.com"]
  spec.homepage    = "https://thombruce.com/"
  spec.summary     = "Rails token auth"
  spec.description = "Provides token-based authentication for Rails API apps."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"
  spec.add_dependency "warden", "~> 1.2.8"
  spec.add_dependency "pundit", "~> 2.1.0"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec", "~> 4.0.0.beta3"
end
