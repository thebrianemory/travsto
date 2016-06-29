class CategoryPolicy < ApplicationPolicy
  def update?
    user.admin? unless !user
  end

  def destroy?
    user.admin? unless !user
  end

  def new?
    user.admin? unless !user
  end

  def edit?
    user.admin? unless !user
  end
end
