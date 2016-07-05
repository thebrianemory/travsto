### Users ###
User.create(
  first_name: "Brian",
  last_name: "Emory",
  email: "the@brianemory.com",
  password: "Batword1",
  password_confirmation: "Batword1",
  username: 'thebrianemory',
  role: 1
)

User.create(
  first_name: "Prince",
  last_name: "Thor",
  email: "mighty.thor@example.com",
  username: "mightythor",
  password: 'password',
  password_confirmation: 'password'
)
User.create(
  first_name: "Steve",
  last_name: "Rogers",
  email: "steve.rogers@example.com",
  username: "steverogers",
  password: 'password',
  password_confirmation: 'password'
)
User.create(
  first_name: "Tony",
  last_name: "Stark",
  email: "tony.stark@example.com",
  username: "tonystark",
  password: 'password',
  password_confirmation: 'password'
)

### Businesses ###
10.times do
  Business.create(
    name: Faker::Company::name
  )
end

### Trips ###
5.times do
  trip = Trip.create(
    title: Faker::Company.catch_phrase,
    description: Faker::Hipster.paragraph + "\n" + Faker::Hipster.paragraph + "\n" + Faker::Hipster.paragraph + "\n" + Faker::Hipster.paragraph,
    user_id: Faker::Number.between(1, 4)
  )
  3.times do
    business = Business.find_by_id(Faker::Number.between(1, 10))
    trip.businesses << business
  end
end

### Comments ###
22.times do
  Comment.create(
    content: Faker::StarWars.quote,
    user_id: Faker::Number.between(1, 4),
    trip_id: Faker::Number.between(1, 2)
  )
end
