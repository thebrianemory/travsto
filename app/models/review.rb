class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :rating, :description, :user_id, :business_id
  validates :description, length: { minimum: 5 }
end
