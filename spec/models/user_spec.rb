require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  before :each do
    @first_user = User.create(first_name: 'John', last_name: 'Doe', username: 'johndoe86', email: 'johndoe@example.com', password: 'password')
  end

  describe "misc" do
    it "is valid with a first name, last name, username, and email" do
      expect(@first_user).to be_valid
    end
    it "returns a user's full name as a string" do
      expect(@first_user.name). to eq 'John Doe'
    end
  end

  describe "has a valid username length" do
    it "has a username between 6 and 15 characters" do
      @first_user.username = 'bobbyjohnson'
      expect(@first_user).to be_valid
    end
    it "cannot have a username less than 6 characters" do
      @first_user.username = 'bobby'
      expect(@first_user).to_not be_valid
    end
    it "it cannot have a username more than 15 characters" do
      @first_user.username = 'bobbyjohnson1234'
      expect(@first_user).to_not be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a first name" do
      user = User.new(first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "is invalid without a last name" do
      user = User.new(last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "is invalid without an username" do
      user = User.new(username: nil)
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
    end
    it "is invalid without an email address" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    it "is invalid with a duplicate email address" do
      user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe88', email: 'johndoe@example.com', password: 'password')
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
    it "is invalid with a duplicate username" do
      user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe86', email: 'johndoe88@example.com', password: 'password')
      user.valid?
      expect(user.errors[:username]).to include("has already been taken")
    end
  end
end
