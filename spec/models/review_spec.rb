require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "misc" do
    it "has a valid factory" do
      expect(build(:review)).to be_valid
    end
    it "is valid with a rating and description" do
      expect(build(:review)).to be_valid
    end

    describe "information cannot be left blank" do
      it "is invalid without a rating" do
        review = build(:review, rating: nil)
        review.valid?
        expect(review.errors[:rating]).to include("can't be blank")
      end
      it "is invalid without a description" do
        review = build(:review, description: nil)
        review.valid?
        expect(review.errors[:description]).to include("can't be blank")
      end
    end

    describe "has a valid desciption length" do
      it "has a description longer than 5 characters" do
        review = build(:review, description: 'This place was cool')
        expect(review).to be_valid
      end
      it "it cannot have a description less than 5 characters" do
        review = build(:review, description: 'Bad')
        expect(review).to_not be_valid
      end
    end
  end
end
