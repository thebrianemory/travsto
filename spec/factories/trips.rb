FactoryGirl.define do
  factory :trip do
    title { Faker::Name.title }
    description { Faker::Hipster.paragraph }
    association :user, factory: :user, strategy: :build
  end
end
