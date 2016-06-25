FactoryGirl.define do
  factory :user do
    first_name "Star"
    last_name "Lord"
    username { "#{first_name}#{last_name}" }
    email { "#{first_name}#{last_name}@example.com" }
    password 'password'
  end

  factory :admin, class: User do
    first_name "Leeloo"
    last_name "Dallas"
    username "leeloodallas"
    email "leedal@example.com"
    password 'adminpass'
    role 1
  end
end
