class CommentTripSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :user, serializer: CommentUserSerializer
end
