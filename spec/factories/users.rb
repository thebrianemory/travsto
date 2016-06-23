FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { "#{last_name}123" }
    email { "#{first_name}#{last_name}@example.com" }
    password 'password'
  end
end
