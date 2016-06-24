class Business < ActiveRecord::Base
  has_many :trips
  has_one :category
  has_many :reviews

  validates_presence_of :name, :category_id
  validates_uniqueness_of :name

  def average_review_rating
    reviews.average(:rating)
  end
end
