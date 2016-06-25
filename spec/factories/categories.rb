FactoryGirl.define do
  factory :category do
    name { Faker::StarWars.specie }
  end
end
