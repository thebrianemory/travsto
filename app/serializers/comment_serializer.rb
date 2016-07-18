class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user
  has_one :trip
end
