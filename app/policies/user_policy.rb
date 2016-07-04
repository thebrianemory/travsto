class UserPolicy < ApplicationPolicy
  def show?
    record.id == user.id || user.admin? unless !user
  end

  def index?
    user.admin? unless !user
  end
end
