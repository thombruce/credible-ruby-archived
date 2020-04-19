require 'warden'

module Credible
  class Engine < ::Rails::Engine
    isolate_namespace Credible
  end
end
