FactoryGirl.define do
  factory :business do
    sequence(:name) { |n| "Weemo's Pizzeria#{n}" }
    factory :invalid_business do
      name nil
    end
  end
end
