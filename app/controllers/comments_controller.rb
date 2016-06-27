class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    redirect_to root_url
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to trip_path(@comment.trip_id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to trip_path(@comment.trip_id)
    else
      render :edit
    end
  end

  def destroy
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
