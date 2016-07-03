require 'rails_helper'

RSpec.describe Business, type: :model do
  describe do
    before(:each) do
      @user = create(:user)
      @business = create(:business)
    end
    describe "misc" do
      it "has a valid factory" do
        expect(@business).to be_valid
      end
    end

    describe "associations" do
      before(:each) do
        @trip = create(:trip, user_id: @user.id)
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
