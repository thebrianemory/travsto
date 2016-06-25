FactoryGirl.define do
  factory :business do
    name { Faker::Company.name }
    category_id 1
  end
end
