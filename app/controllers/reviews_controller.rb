class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    redirect_to root_url
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    if @review.save
      redirect_to business_path(@review.business_id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to business_path(@review.business_id)
    else
      render :edit
    end
  end

  def destroy
    business = Business.find_by_id(@review.business_id)
    @review.destroy
    redirect_to business_path(business)
  end

  private
  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:description, :rating, :user_id, :business_id)
  end
end
