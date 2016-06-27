require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @business = create(:business)
    @comment = create(:comment)
    @user = User.find_by_id(@comment.user.id)
    @trip = Trip.find_by_id(@comment.trip.id)
  end

  describe "misc" do
    it "has a valid factory" do
      expect(@comment).to be_valid
    end
    it "is valid with content" do
      expect(@comment).to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      expect(@comment.user).to eq(@user)
    end
    it "belongs to a trip" do
      expect(@comment.trip).to eq(@trip)
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without content" do
      @comment.content = nil
      @comment.valid?
      expect(@comment.errors[:content]).to include("can't be blank")
    end
  end
end
