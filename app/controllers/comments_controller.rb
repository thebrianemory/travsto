class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @comments = Comment.all
    authorize Comment
  end

  def show
    authorize @comment
  end

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    if @comment.save
      redirect_to trip_path(@comment.trip.slug)
    else
      render :new
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      redirect_to trip_path(@comment.trip.slug)
    else
      render :edit
    end
  end

  def destroy
    authorize @comment
    trip = Trip.find_by_id(@comment.trip_id)
    @comment.destroy
    redirect_to trip_path(trip)
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :trip_id)
  end
end
