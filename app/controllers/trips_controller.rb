class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
    authorize_trip
  end

  def create
    @trip = Trip.new(trip_params)
    authorize_trip
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def show
  end

  def edit
    authorize_trip
  end

  def update
    authorize_trip
    if @trip.update(trip_params)
      redirect_to @trip
    else
      render :edit
    end
  end

  def destroy
    authorize_trip
    @trip.destroy
    redirect_to trips_path
  end

  private
  def authorize_trip
    authorize @trip
  end

  def set_trip
    @trip = Trip.friendly.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:title, :description, :user_id)
  end
end
