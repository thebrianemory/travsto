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

  describe "has a valid title length" do
    it "has a title between 5 and 50 characters" do
      trip = build(:trip, title: 'My Trip to Beautiful Italy')
      expect(trip).to be_valid
    end
    it "cannot have a title less than 5 characters" do
      trip = build(:trip, title: 'Trip')
      expect(trip).to_not be_valid
    end
    it "it cannot have a title more than 50 characters" do
      trip = build(:trip, title: 'I took a trip to a place and did a bunch of things so that was cool')
      expect(trip).to_not be_valid
    end
  end

  describe "has a valid desciption length" do
    it "has a description longer than 100 characters" do
      trip = build(:trip, description: 'I took a trip to a place and did a bunch of things so that was cool I took a trip to a place and did a bunch of things so that was cool')
      expect(trip).to be_valid
    end
    it "it cannot have a description less than 100 characters" do
      trip = build(:trip, description: 'I took a trip to a place and did a bunch of things so that was cool')
      expect(trip).to_not be_valid
    end
  end
end
