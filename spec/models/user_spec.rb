require 'rails_helper'

RSpec.describe User, type: :model do
  describe "misc" do
    before(:each) do
      @user = create(:user)
    end
    it "has a valid factory" do
      expect(@user).to be_valid
    end
    it "is valid with a first name, last name, username, and email" do
      expect(@user).to be_valid
    end
    it "returns a user's full name as a string" do
      @user.first_name = 'John'
      @user.last_name = 'Doe'
      expect(@user.name).to eq 'John Doe'
    end
  end

  describe "associations" do
    before(:each) do
      @user = create(:user)
      @category = create(:category)
      @business = create(:business, category_id: @category.id)
      @review = create(:review, user_id: @user.id, business_id: @business.id)
      @trip = create(:trip, user_id: @user.id)
      @comment = create(:comment, user_id: @user.id, trip_id: @trip.id)
    end
    it "has many trips" do
      @user.trips << @trip
      @user.save
      expect(@user.trips.count).to eq 1
    end
    it "has many reviews" do
      @user.reviews << @review
      @user.save
      expect(@user.reviews.count).to eq 1
    end
    it "has many comments" do
      @user.comments << @comment
      @user.save
      expect(@user.comments.count).to eq 1
    end
  end

  describe "has a valid username" do
    before(:each) do
      @user = create(:user)
    end
    it "has a username between 6 and 15 characters" do
      @user.username = 'bobbyjohnson'
      expect(@user).to be_valid
    end
    it "cannot have a username less than 6 characters" do
      @user.username = 'bobby'
      expect(@user).to_not be_valid
    end
    it "it cannot have a username more than 15 characters" do
      @user.username = 'bobbyjohnson1234'
      expect(@user).to_not be_valid
    end
      it 'cannot have spaces' do
        @user.username = 'bob johnson'
        expect(@user).to_not be_valid
      end
      it 'cannot have special characters' do
        @user.username = 'bob$%johnson'
        expect(@user).to_not be_valid
      end
  end

  describe "information cannot be left blank" do
    before(:each) do
      @user = build(:user)
    end
    it "is invalid without a first name" do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without an username" do
      @user.username = nil
      @user.valid?
      expect(@user.errors[:username]).to include("can't be blank")
    end
    it "is invalid without an email address" do
      @user.email = nil
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      @user.password = nil
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    before(:each) do
      @user1 = create(:user, email: 'dup@example.com', username: 'duplicate')
    end
    it "is invalid with a duplicate email address" do
      user2 = build(:user, email: 'dup@example.com')
      user2.valid?
      expect(user2.errors[:email]).to include("has already been taken")
    end
    it "is invalid with a duplicate username" do
      user2 = build(:user, username: 'duplicate')
      user2.valid?
      expect(user2.errors[:username]).to include("has already been taken")
    end
  end
end
