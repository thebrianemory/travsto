require 'rails_helper'

RSpec.describe Trip, type: :model do
  before(:each) do
    @business = create(:business)
    @trip = create(:trip)
    @user = User.find_by_id(@trip.user.id)
    @comment = create(:comment, user_id: @user.id, trip_id: @trip.id)
  end

  describe "misc" do
    it "has a valid factory" do
      expect(@trip).to be_valid
    end
    it "is valid with a title and description" do
      expect(@trip).to be_valid
    end
  end

  describe "association" do
    it "belongs to a user" do
      expect(@trip.user).to eq(@user)
    end
    it "has many businesses" do
      @trip.businesses << @business
      @trip.save
      expect(@trip.businesses.count).to eq 1
    end
    it "has many comments" do
      @trip.comments << @comment
      @trip.save
      expect(@trip.comments.count).to eq 1
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a title" do
      @trip.title = nil
      @trip.valid?
      expect(@trip.errors[:title]).to include("can't be blank")
    end
    it "is invalid without a description" do
      @trip.description = nil
      @trip.valid?
      expect(@trip.errors[:description]).to include("can't be blank")
    end
  end

  describe "has a valid title length" do
    it "has a title between 5 and 50 characters" do
      @trip.title = 'My Trip to Beautiful Italy'
      expect(@trip).to be_valid
    end
    it "cannot have a title less than 5 characters" do
      @trip.title = 'Trip'
      expect(@trip).to_not be_valid
    end
    it "it cannot have a title more than 50 characters" do
      @trip.title = 'I took a trip to a place and did a bunch of things so that was cool'
      expect(@trip).to_not be_valid
    end
  end

  describe "title is slugifiable" do
    it 'turns the its title into a slug' do
      trip = create(:trip, title: "this isn't my Title FOR my trip")
      expect(trip.slug).to eq("this-isn-t-my-title-for-my-trip")
    end
  end

  describe "has a valid desciption length" do
    it "has a description longer than 100 characters" do
      @trip.description = 'I took a trip to a place and did a bunch of things so that was cool I took a trip to a place and did a bunch of things so that was cool'
      expect(@trip).to be_valid
    end
    it "it cannot have a description less than 100 characters" do
      @trip.description = 'I took a trip to a place and did a bunch of things so that was cool'
      expect(@trip).to_not be_valid
    end
  end
end
