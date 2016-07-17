class UserTripSerializer < ActiveModel::Serializer
  attributes :id, :username, :slug, :name
end
