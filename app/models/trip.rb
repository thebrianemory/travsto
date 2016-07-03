class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :business_trips
  has_many :businesses, through: :business_trips
  validates_presence_of :title, :description, :user_id
  validates :title, length: 5..50
  validates :description, length: { minimum: 100 }
  accepts_nested_attributes_for :businesses, reject_if: :all_blank

  extend FriendlyId
  friendly_id :title, use: :slugged

  def businesses_attributes=(business_attributes)
    business_attributes.each do |biz_attributes|
      biz_attributes.values.each do |business_attribute|
        business = Business.find_or_create_by(name: biz_attributes.values.first)
        self.businesses << business
      end
    end
  end
end
