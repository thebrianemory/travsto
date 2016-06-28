class Business < ActiveRecord::Base
  has_many :trips
  belongs_to :category
  has_many :reviews
  has_many :business_trips
  has_many :trips, through: :business_trips
  validates_presence_of :name, :category_id
  validates_uniqueness_of :name

  def average_review_rating
    reviews.average(:rating)
  end

  def slug
    self.name.gsub!(/['`"]/,"")
    self.name.gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '-').downcase
  end
end
