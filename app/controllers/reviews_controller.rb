class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @reviews = Review.all
    authorize Review
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    if @review.save
      redirect_to business_path(@review.business_id)
    else
      render :new
    end
  end

  def show
    authorize @review
  end

  def edit
    authorize @review
  end

  def update
    authorize @review
    if @review.update(review_params)
      redirect_to business_path(@review.business_id)
    else
      render :edit
    end
  end

  def destroy
    authorize @review
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
