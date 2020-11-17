require 'faker'
require 'open-uri'
require 'pry'

puts 'clearing db...'
Booking.destroy_all
Boat.destroy_all
User.destroy_all

puts 'adding user...'
alice = User.create!(username: "Alice", email: "alice@example.com", password: "123456")

puts 'adding boats...'
cities = ["Munich", "Berlin"]
count = 0
cities.each do |city|
  5.times do
    count += 1
    image = URI.open('https://source.unsplash.com/collection/1496998')
    boat = Boat.new(
      name: Faker::TvShows::GameOfThrones.house,
      description: Faker::TvShows::GameOfThrones.quote,
      location: city,
      price: Faker::Number.within(range: 50..500),
      image: image
    )
    boat.image.attach(io: image, filename: "image#{count}", content_type: 'image/png')
    boat.user = alice
    boat.save!
    puts boat
  end
end


# Boat.create(name: "Marina", price: 150, description: "famous", location: "Port of Brac", user_id: 1,)
# Boat.create(name: "Novi Sad", price: 190, description: "luxury", location: "Port of Budva",user_id: 1,)
# Boat.create(name: "Black Pearl", price: 140, description: "party", location: "Port of London", user_id: 1,)
# Boat.create(name: "Titanic", price: 90, description: "dead", location: "Port of Liverpool", user_id: 1,)
