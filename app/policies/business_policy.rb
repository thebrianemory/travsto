class BusinessPolicy < ApplicationPolicy

  def index?
    user.admin? unless !user
  end

  def destroy?
    user.admin? unless !user
  end

  def new?
    user || user.admin? unless !user
  end

  def create?
    user || user.admin? unless !user
  end

  def edit?
    user.admin? unless !user
  end

  def update?
    user.admin? unless !user
  end
end
