class Credible::AuthenticationController < ApplicationController
  # TODO: Authentication module is now redundant inside Credible Engine.
  #       Migrate out of namespace.

  def policy_scope(scope)
    super([:credible, :authentication, scope])
  end

  def authorize(record, query = nil)
    super([:credible, :authentication, record], query)
  end

  def permitted_attributes(record, action = action_name)
    super([:credible, :authentication, record], action)
  end
end
