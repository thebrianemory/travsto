class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  def index
    @businesses = Business.all
  end

  def show
  end

  def new
    @business = Business.new
  end

  private
  def set_business
    @business = Business.find(params[:id])
  end
end
