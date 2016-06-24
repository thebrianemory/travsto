### Users ###
User.create(
  first_name: "Brian",
  last_name: "Emory",
  email: "the@brianemory.com",
  password: "Batword1",
  username: 'thebrianemory',
  role: 1
)

User.create(
  first_name: "Prince",
  last_name: "Thor",
  email: Faker::Internet.safe_email("mighty.thor"),
  username: "mightythor",
  password: 'password'
)
User.create(
  first_name: "Steve",
  last_name: "Rogers",
  email: Faker::Internet.safe_email("steve.rogers"),
  username: "steverogers",
  password: 'password'
)
User.create(
  first_name: "Tony",
  last_name: "Stark",
  email: Faker::Internet.safe_email("tony.stark"),
  username: "tonystark",
  password: 'password'
)

### Categories ###
Category.create(
  name: "Restaurant"
)
Category.create(
  name: "Hotel"
)
Category.create(
  name: "Attraction"
)

### Businesses ###
10.times do
  Business.create(
  name: Faker::Company::name
  category_id: Faker::Number.between(1, 3)
  )
end

### Reviews ###
25.times do
  Review.create(
  description:
  rating:
  user_id: Faker::Number.between(1, 4)
  business_id: Faker::Number.between(1, 4)
  )
end
