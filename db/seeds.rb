require 'faker'

alice = User.create(username: "Alice", email: "alice@example.com", password: "123456")

cities = ["Munich", "Berlin", "London"]
cities.each do |city|
  5.times do
    boat = Boat.new(
      name: Faker::TvShows::GameOfThrones.house,
      description: Faker::TvShows::GameOfThrones.quote,
      location: city,
      price: Faker::Number.within(range: 50..500),
      image:
    )
    boat.user = alice
  end
end


# Boat.create(name: "Marina", price: 150, description: "famous", location: "Port of Brac", user_id: 1,)
# Boat.create(name: "Novi Sad", price: 190, description: "luxury", location: "Port of Budva",user_id: 1,)
# Boat.create(name: "Black Pearl", price: 140, description: "party", location: "Port of London", user_id: 1,)
# Boat.create(name: "Titanic", price: 90, description: "dead", location: "Port of Liverpool", user_id: 1,)
