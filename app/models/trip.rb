class Trip < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description
  validates :title, length: 5..50
  validates :description, length: { minimum: 100 }
end
