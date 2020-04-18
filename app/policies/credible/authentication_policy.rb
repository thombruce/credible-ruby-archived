class Credible::AuthenticationPolicy < Credible::ApplicationPolicy
  # Authentication concerns the User and their single instance.
  # The rules that apply to update? will always apply to show?
  # and destroy? too.
  def show?
    update?
  end

  def create?
    !user
  end

  def destroy?
    update?
  end
end
