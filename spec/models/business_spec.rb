require 'rails_helper'

RSpec.describe Business, type: :model do
  describe do
    before(:each) do
      @user = create(:user)
      @business = create(:business)
      @review = create(:review, user_id: @user.id, business_id: @business.id)
      @category = Category.find_by_id(@business.category_id)
    end
    describe "misc" do
      it "has a valid factory" do
        expect(@business).to be_valid
      end
      it "is valid with a name and category_id" do
        expect(@business).to be_valid
      end
      it "returns a business' average rating" do
        @business.reviews << build(:review, user_id: @user.id, rating: 2)
        @business.save
        expect(@business.average_review_rating).to eq 3
      end
    end

    describe "associations" do
      before(:each) do
        @trip = create(:trip, user_id: @user.id)
      end
      it "belongs to a category" do
        expect(@business.category).to eq(@category)
      end
      it "has many reviews" do
        @business.reviews << @review
        @business.save
        expect(@business.reviews.count).to eq 1
      end
      it "has many trips" do
        @business.trips << @trip
        @business.save
        expect(@business.trips.count).to eq 1
      end
    end
  end

  describe "name is slugifiable" do
    it 'turns the its name into a slug' do
      business = create(:business, name: "Weemo's Pizzeria")
      expect(business.slug).to eq("weemo-s-pizzeria")
    end
  end

  describe "information cannot be left blank" do
    before(:each) do
      @business = build(:business)
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
      @business1 = create(:business, name: "Weemo's Pizzeria")
    end
    it "is invalid with a duplicate name" do
      business2 = build(:business, name: "Weemo's Pizzeria")
      business2.valid?
      expect(business2.errors[:name]).to include("has already been taken")
    end
  end
end
