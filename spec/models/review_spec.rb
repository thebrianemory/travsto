require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "misc" do
    it "has a valid factory" do
      expect(build(:review)).to be_valid
    end
    it "is valid with a rating and description" do
      expect(build(:review)).to be_valid
    end
  end
end
