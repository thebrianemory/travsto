class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :business_trips
  has_many :businesses, through: :business_trips
  validates_presence_of :title, :description, :user
  validates :title, length: 5..50
  validates :description, length: { minimum: 100 }

  extend FriendlyId
  friendly_id :title, use: :slugged
end
