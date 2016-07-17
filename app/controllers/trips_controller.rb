class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :update, :destroy]
  before_action :authorize_trip, only: [:edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    if params[:user_id]
      @user = User.friendly.find(params[:user_id])
      if @user.nil?
        redirect_to trips_path, alert: "User not found"
      else
        @trips = @user.trips
      end
    else
      @trips = Trip.all
    end
  end

  def new
    if current_user.username == params[:user_id]
      @trip = Trip.new
      authorize_trip
    else
      redirect_to new_user_trip_path(current_user), alert: "You can only create travel stories for yourself"
    end
  end

  def create
    @trip = current_user.trips.build(trip_params)
    authorize_trip
    if @trip.save
      redirect_to user_trip_path(@trip.user, @trip)
    else
      render :new
    end
  end

  def show
    if params[:user_id] && params[:id]
      @user = User.friendly.find(params[:user_id])
      @trip = @user.trips.friendly.find(params[:id])
      if @trip.nil? || @user.nil?
        redirect_to user_trips_path(@user), alert: "Please check your link and try again"
      end
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @trip }
      end
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private
  def set_trip
    @trip = Trip.friendly.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:title, :description, :user_id, business_ids:[], businesses_attributes: [:name])
  end

  def authorize_trip
    authorize @trip
  end
end
