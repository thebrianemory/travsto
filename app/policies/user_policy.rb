class UserPolicy < ApplicationPolicy
  permit_admin_to :index
  permit_admin_or_users_record_to :show
end
