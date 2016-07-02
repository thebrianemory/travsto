class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  has_many :business_trips
  has_many :trips, through: :business_trips
  validates_presence_of :name, :category_id
  validates_uniqueness_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged

  def average_review_rating
    reviews.average(:rating)
  end
  #
  # def categories_attributes=(category_attributes)
  #   category_attributes.values.each do |category_attribute|
  #     category = Category.find_or_create_by(category_attribute)
  #     self.categories << category
  #   end
  # end
end
