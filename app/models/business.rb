class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  has_many :business_trips
  has_many :trips, through: :business_trips
  validates_presence_of :name, :category
  validates_uniqueness_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged

  def average_review_rating
    reviews.average(:rating)
  end
end
