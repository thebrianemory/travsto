class BusinessTrip < ActiveRecord::Base
  belongs_to :business
  belongs_to :trip
end
