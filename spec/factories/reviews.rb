FactoryGirl.define do
  factory :review do
    description "I wouldn't say this was the best nor the worst."
    rating 4
    association :user, factory: :user, strategy: :create
    association :business, factory: :business, strategy: :create
  end
end
