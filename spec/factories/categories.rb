FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Restaurant#{n}" }
    factory :invalid_category do
      name nil
    end
  end
end
