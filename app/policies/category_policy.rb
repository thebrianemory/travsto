class CategoryPolicy < ApplicationPolicy
  def destroy?
    user.admin? unless !user
  end

  def new?
    user.admin? unless !user
  end

  def create?
    user.admin? unless !user
  end

  def edit?
    user.admin? unless !user
  end

  def update?
    user.admin? unless !user
  end
end
