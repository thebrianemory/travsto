FactoryGirl.define do
  factory :business do
    sequence(:name) { |n| "Weemo's Pizzeria#{n}" }
    category_id 1

    factory :invalid_business do
      name nil
    end
  end
end
