class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @businesses = Business.all
  end

  def show
  end

  def edit
    authorize @business
  end

  def update
    authorize @business
    if @business.update(business_params)
      redirect_to @business
    else
      render :edit
    end
  end

  def destroy
    authorize @business
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
