require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with a name" do
    category = Category.new(name: "Restaurant")
    expect(category).to be_valid
  end
end
