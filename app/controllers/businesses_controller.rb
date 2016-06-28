class BusinessesController < ApplicationController
  before_action :verify_is_admin
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  def index
    @businesses = Business.all
  end

  def show
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.create(business_params)
    if @business.save
      redirect_to business_path(@business)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @business.update(business_params)
      redirect_to @business
    else
      render :edit
    end
  end

  def destroy
    @business.destroy
    redirect_to businesses_path
  end

  private
  def set_business
    @business = Business.friendly.find(params[:id])
  end

  def business_params
    params.require(:business).permit(:name, :category_id)
  end
end
