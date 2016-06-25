require 'rails_helper'

RSpec.describe Business, type: :model do
  describe "misc" do
    it "has a valid factory" do
      expect(build(:business)).to be_valid
    end
    it "is valid with a name and category_id" do
      expect(build(:business)).to be_valid
    end
    it "returns a business' average rating" do
      category = create(:category)
      business = create(:business, category_id: category.id)
      user = create(:user)
      business.reviews << create(:review, business_id: business.id, user_id: user.id)
      business.reviews << create(:review, rating: 2, business_id: business.id, user_id: user.id)
      expect(business.average_review_rating).to eq 3
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a name" do
      business = build(:business, name: nil)
      business.valid?
      expect(business.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a category_id" do
      business = build(:business, category_id: nil)
      business.valid?
      expect(business.errors[:category_id]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    it "is invalid with a duplicate name" do
      category = create(:category)
      business1 = create(:business, name: "Weemo's Pizzeria", category_id: category.id)
      business2 = build(:business, name: "Weemo's Pizzeria", category_id: category.id)
      business2.valid?
      expect(business2.errors[:name]).to include("has already been taken")
    end
  end
end
