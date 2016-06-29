class TripPolicy < ApplicationPolicy
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