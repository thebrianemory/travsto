FactoryGirl.define do
  factory :user do
    first_name "Star"
    last_name "Lord"
    sequence(:username) { |n| "starlord#{n}" }
    sequence(:email) { |n| "starlord#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :admin, class: User do
    first_name "Leeloo"
    last_name "Dallas"
    username "leeloodallas"
    email "leedal@example.com"
    password 'adminpass'
    password_confirmation 'adminpass'
    role 1
  end
end
