class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_many :businesses, serializer: BusinessTripSerializer
  has_one :user, serializer: UserTripSerializer
  has_many :comments, serializer: CommentTripSerializer
end
