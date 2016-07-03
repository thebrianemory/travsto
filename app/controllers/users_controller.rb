class UsersController < ApplicationController
  before_action :set_user, only: [:my_trips]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.friendly.find(params[:id])
    redirect_to root_url unless current_user.role == "admin" || @user == current_user
  end

  def my_trips
    @my_trips = @user.trips
  end

  private
  def set_user
    @user = User.friendly.find(params[:username])
  end
end
