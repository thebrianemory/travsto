class TripPolicy < ApplicationPolicy
  def update?
    record == user || user.admin?
  end

  def destroy?
    record.user_id == user.id || user.admin?
  end
end
