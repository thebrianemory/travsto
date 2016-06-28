class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
  end

  def trips
    @user = User.friendly.find(params[:username])
    @my_trips = @user.trips
  end
end
