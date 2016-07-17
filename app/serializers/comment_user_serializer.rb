class CommentUserSerializer < ActiveModel::Serializer
  attributes :id, :username, :slug
end
