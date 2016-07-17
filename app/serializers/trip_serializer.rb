class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :slug
  has_many :businesses, serializer: BusinessTripSerializer
  has_one :user, serializer: UserTripSerializer
  has_many :comments, serializer: CommentTripSerializer
end
