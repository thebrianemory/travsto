class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  validates_presence_of :content
end
