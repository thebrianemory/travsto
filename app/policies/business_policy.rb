class BusinessPolicy < ApplicationPolicy
  permit_admin_to :index, :destroy, :edit, :update
  permit_admin_or_user_to :new, :create
end
