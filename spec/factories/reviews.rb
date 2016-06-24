FactoryGirl.define do
  factory :review do
    description { Faker::Hipster.sentence }
    rating 4
    user_id 1
    business_id 1
  end
end
