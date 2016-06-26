FactoryGirl.define do
  factory :business do
    sequence(:name) { |n| "Weemo's Pizzeria#{n}" }
    association :category, factory: :category, strategy: :create
    factory :invalid_business do
      name nil
    end
  end
end
