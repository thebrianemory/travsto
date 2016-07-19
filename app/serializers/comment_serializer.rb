class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user, :updated_at
  has_one :trip
end
