class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :business_trips
  has_many :businesses, through: :business_trips
  validates_presence_of :title, :description, :user_id
  validates :title, length: 5..50
  validates :description, length: { minimum: 100 }

  extend FriendlyId
  friendly_id :title, use: :slugged

  def attributes_blank?(attrs)
    attrs.except('id').values.all?(&:blank?)
  end

  def businesses_attributes=(business_attributes)
    business_attributes.values.each do |business_attribute|
      if !business_attribute["name"].blank?
        binding.pry
        business = Business.find_or_create_by(business_attribute)
        self.businesses << business
      end
    end
  end
end
