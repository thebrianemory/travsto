FactoryGirl.define do
  factory :comment do
    content "This is cool"
    association :user, factory: :user, strategy: :create
    association :trip, factory: :trip, strategy: :create
  end
end
