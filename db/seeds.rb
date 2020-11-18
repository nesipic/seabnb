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
cities = ["Split, Sustipanski put 1", "Tivat, Porto Montenegro "]
count = 0
cities.each do |city|
  5.times do
    count += 1
    image = URI.open('https://source.unsplash.com/collection/1496998')
    boat = Boat.new(
      name: Faker::TvShows::GameOfThrones.house,
      description: Faker::TvShows::GameOfThrones.quote,
      address: city,
      price: Faker::Number.within(range: 50..500),
      image: image
    )
    boat.image.attach(io: image, filename: "image#{count}", content_type: 'image/png')
    boat.user = alice
    boat.save!
    puts boat
  end
end
