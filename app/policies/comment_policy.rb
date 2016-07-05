class CommentPolicy < ApplicationPolicy
  permit_admin_to :index, :show
  permit_admin_or_user_to :new, :create
  permit_admin_or_user_on_record_to :destroy, :edit, :update

end
