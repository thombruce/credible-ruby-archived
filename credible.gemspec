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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"
  spec.add_dependency "warden", "~> 1.2.8"
  spec.add_dependency "pundit", "~> 2.1.0"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec", "~> 4.0.0.beta3"
end
