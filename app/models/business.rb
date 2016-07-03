class Business < ActiveRecord::Base
  has_many :business_trips
  has_many :trips, through: :business_trips
  validates_uniqueness_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged
end
