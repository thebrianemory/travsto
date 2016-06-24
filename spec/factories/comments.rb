FactoryGirl.define do
  factory :comment do
    content "This is cool"
    user_id 1
    trip_id 1
  end
end
