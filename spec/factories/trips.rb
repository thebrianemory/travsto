FactoryGirl.define do
  factory :trip do
    title { Faker::Name.title }
    description 'I took a trip to a place and did a bunch of things so that was cool. I then took another trip to another place and did a bunch of things so that was cool.'
    association :user, factory: :user, strategy: :build
  end
end
