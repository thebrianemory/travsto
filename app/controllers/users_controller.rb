class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    redirect_to root_url unless current_user.role == "admin" || @user == current_user
  end

  def my_trips
    set_user_by_username
    @my_trips = @user.trips
  end

  def my_reviews
    set_user_by_username
    @my_reviews = @user.reviews
  end

  private
  def set_user_by_username
    @user = User.friendly.find(params[:username])
  end
end
