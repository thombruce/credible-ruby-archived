class Credible::Authentication::UserPolicy < Credible::AuthenticationPolicy
  def permitted_attributes
    [:name, :email, :password]
  end

  def confirm?
    true
  end

  def reset_password?
    true
  end

  def update?
    user && user == record
  end
end
