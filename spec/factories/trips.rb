FactoryGirl.define do
  factory :trip do
    title { Faker::Name.title }
    description 'I took a trip to a place and did a bunch of things so that was cool. I took a trip to a place and did a bunch of things so that was cool.'
    association :user, factory: :user, strategy: :build
  end
end
