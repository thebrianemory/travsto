require 'rails_helper'

RSpec.describe Business, type: :model do
  describe "misc" do
    before(:each) do
      @user = build(:user)
      @category = create(:category)
      @business = build(:business, category_id: @category.id)
      @review = build(:review, user_id: @user.id, business_id: @business.id)
    end
    it "has a valid factory" do
      expect(@business).to be_valid
    end
    it "is valid with a name and category_id" do
      expect(@business).to be_valid
    end
    it "returns a business' average rating" do
      @business.reviews << @review
      @business.reviews << build(:review, user_id: @user.id, business_id: @business.id, rating: 2)
      @business.save
      expect(@business.average_review_rating).to eq 3
    end
  end

  describe "information cannot be left blank" do
    before(:each) do
      @category = create(:category)
      @business = build(:business, category_id: @category.id)
    end
    it "is invalid without a name" do
      @business.name = nil
      @business.valid?
      expect(@business.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a category_id" do
      @business.category_id = nil
      @business.valid?
      expect(@business.errors[:category_id]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    before(:each) do
      @category = create(:category)
      @business1 = create(:business, name: "Weemo's Pizzeria", category_id: @category.id)
    end
    it "is invalid with a duplicate name" do
      business2 = build(:business, name: "Weemo's Pizzeria", category_id: @category.id)
      business2.valid?
      expect(business2.errors[:name]).to include("has already been taken")
    end
  end
end
