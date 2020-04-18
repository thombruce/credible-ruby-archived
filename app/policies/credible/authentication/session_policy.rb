class Credible::Authentication::SessionPolicy < Credible::AuthenticationPolicy
  def permitted_attributes
    [:login, :password]
  end

  def update?
    user && user == record.user
  end
end
