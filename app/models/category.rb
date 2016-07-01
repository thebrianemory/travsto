class Category < ActiveRecord::Base
  has_many :businesses
  validates :name, presence: true, uniqueness: true

  extend FriendlyId
  friendly_id :name, use: :slugged
end
