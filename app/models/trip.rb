class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :business_trips, dependent: :destroy
  has_many :businesses, through: :business_trips
  validates_presence_of :title, :description, :user_id
  validates :title, length: 5..50
  validates :description, length: { minimum: 100 }

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.most_businesses
    Trip.select('trips.*, count(businesses.id) as business_count').
  joins(:businesses).
  group('trips.id').
  order('business_count DESC LIMIT 1')
  end

  def businesses_attributes=(business_attributes)
    business_attributes.each do |biz_attributes|
      unless biz_attributes["name"].blank?
        biz_attributes.values.each do |business_attribute|
          business = Business.find_or_create_by(name: biz_attributes.values.first)
          self.businesses << business
        end
      end
    end
  end
end
