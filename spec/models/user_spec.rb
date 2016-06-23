require 'rails_helper'

RSpec.describe User, type: :model do

  describe "misc" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
    it "is valid with a first name, last name, username, and email" do
      expect(build(:user)).to be_valid
    end
    it "returns a user's full name as a string" do
      user = build(:user, first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq 'John Doe'
    end
  end

  describe "has a valid username length" do
    it "has a username between 6 and 15 characters" do
      user = build(:user, username: 'bobbyjohnson')
      expect(user).to be_valid
    end
    it "cannot have a username less than 6 characters" do
      user = build(:user, username: 'bobby')
      expect(user).to_not be_valid
    end
    it "it cannot have a username more than 15 characters" do
      user = build(:user, username: 'bobbyjohnson1234')
      expect(user).to_not be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a first name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without an username" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
    end
    it "is invalid without an email address" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    it "is invalid with a duplicate email address" do
      user1 = create(:user, email: 'duplicate@example.com')
      user2 = build(:user, email: 'duplicate@example.com')
      user2.valid?
      expect(user2.errors[:email]).to include("has already been taken")
    end
    it "is invalid with a duplicate username" do
      user1 = create(:user, username: 'duplicate')
      user2 = build(:user, username: 'duplicate')
      user2.valid?
      expect(user2.errors[:username]).to include("has already been taken")
    end
  end
end
