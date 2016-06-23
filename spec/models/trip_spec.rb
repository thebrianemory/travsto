require 'rails_helper'

RSpec.describe Trip, type: :model do

  describe "misc" do
    it "has a valid factory" do
      expect(build(:trip)).to be_valid
    end
    it "is valid with a title and description" do
      expect(build(:trip)).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a title" do
      trip = build(:trip, title: nil)
      trip.valid?
      expect(trip.errors[:title]).to include("can't be blank")
    end
    it "is invalid without a description" do
      trip = build(:trip, description: nil)
      trip.valid?
      expect(trip.errors[:description]).to include("can't be blank")
    end
  end
end
