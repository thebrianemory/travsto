class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :rating, :description, :user, :business
  validates :description, length: { minimum: 5 }
end
