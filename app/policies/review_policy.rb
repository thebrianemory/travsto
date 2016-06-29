class ReviewPolicy < ApplicationPolicy
  def index?
    user.admin? unless !user
  end

  def show?
    user.admin? unless !user
  end

  def destroy?
    record.user_id == user.id || user.admin? unless !user
  end

  def new?
    user || user.admin? unless !user
  end

  def create?
    user || user.admin? unless !user
  end

  def edit?
    record.user_id == user.id || user.admin? unless !user
  end

  def update?
    record.user_id == user.id || user.admin? unless !user
  end
end
