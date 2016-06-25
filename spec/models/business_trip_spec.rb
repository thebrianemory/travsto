require 'rails_helper'

RSpec.describe BusinessTrip, type: :model do
  before(:each) do
    @user = create(:user)
    @category = create(:category)
    @business = create(:business, category_id: @category.id)
    @trip = create(:trip, user_id: @user.id)
    @business_trip = create(:business_trip, trip_id: @trip.id, business_id: @business.id)
  end

  describe "associations" do
    it "belongs to a trip" do
      expect(@business_trip.trip).to eq(@trip)
    end
    it "belongs to a business" do
      expect(@business_trip.business).to eq(@business)
    end
  end
end
