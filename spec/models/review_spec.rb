require 'rails_helper'

RSpec.describe Review, type: :model do
  before(:each) do
    @review = create(:review)
    @user = User.find_by_id(@review.user.id)
    @business = Business.find_by_id(@review.business.id)
  end
  describe "misc" do
    it "has a valid factory" do
      expect(@review).to be_valid
    end
    it "is valid with a rating and description" do
      expect(@review).to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      expect(@review.user).to eq(@user)
    end
    it "belongs to a business" do
      expect(@review.business).to eq(@business)
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a rating" do
      @review.rating = nil
      @review.valid?
      expect(@review.errors[:rating]).to include("can't be blank")
    end
    it "is invalid without a description" do
      @review.description = nil
      @review.valid?
      expect(@review.errors[:description]).to include("can't be blank")
    end
  end

  describe "has a valid desciption length" do
    it "has a description longer than 5 characters" do
      @review.description = 'This place was cool'
      expect(@review).to be_valid
    end
    it "it cannot have a description less than 5 characters" do
      @review.description = 'Bad'
      expect(@review).to_not be_valid
    end
  end
end
