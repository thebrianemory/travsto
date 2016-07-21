class UserTripSerializer < ActiveModel::Serializer
  attributes :id, :username, :slug, :first_name, :last_name
end
