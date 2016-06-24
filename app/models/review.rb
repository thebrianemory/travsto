class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :rating, :description
end
