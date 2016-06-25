FactoryGirl.define do
  factory :review do
    description "I wouldn't say this was the best nor the worst."
    rating 4
    user_id 1
    business_id 1
  end
end
