class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :slug
  has_many :trips
  has_many :comments
end
