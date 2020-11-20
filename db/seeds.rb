require 'open-uri'
require 'nokogiri'

puts 'clearing db...'
Booking.destroy_all
Boat.destroy_all
User.destroy_all

puts 'adding users...'
alice = User.new(username: "Alice", email: "alice@example.com", password: "123456")
alice.picture.attach(io: URI.open("https://source.unsplash.com/38dk7QXDBzs"), filename: "alice", content_type: 'image/png')
alice.save!
bob = User.create!(username: "Bob", email: "bob@example.com", password: "123456")
bob.picture.attach(io: URI.open("https://source.unsplash.com/ZGa9d1a_4tA"), filename: "bob", content_type: 'image/png')
bob.save!
cindy = User.create!(username: "Cindy", email: "cindy@example.com", password: "123456")
cindy.picture.attach(io: URI.open("https://source.unsplash.com/i5R8hbZFDdc"), filename: "cindy", content_type: 'image/png')
cindy.save!

puts 'adding boats...'
cities = ["San Francisco", "Split, Croatia", "Tivat, Montenegro"]
users = [alice, bob, cindy]
cities.each_with_index do |city, i|
  boats = []
  file = Nokogiri::HTML(URI.open("https://www.clickandboat.com/en/boat-rental/search?where=#{city}"))
  file.search('.boatAd__description > a').first(5).each do |link|
    boats << link.attribute('href')
  end

  boats.each do |boat_link|
    boat = Nokogiri::HTML(URI.open(boat_link))
    name = boat.search('.productGeneral__title').first.content.strip.gsub(/â\u0080\u0094/, '')
    description = boat.search('.productDescription__text').first.content.strip
    address = boat.search('.productGeneral__text--grey').first.content.strip
    price = boat.search('.amount').first.content.strip.gsub(/,/, '').to_f
    image = boat.search('.js-openGallery').first.attribute('style').content.gsub(/background-image: url\(/, 'https:').gsub(/\);/, '')
    boat = Boat.new(
      name: name,
      description: description,
      address: address,
      price: price
    )
    boat.image.attach(io: URI.open(image), filename: image, content_type: 'image/png')
    boat.user = users[i]
    boat.save!
    puts "Name: #{boat.name}, Owner: #{boat.user.username}, Location: #{city}"
  end
end

puts 'adding bookings...'
booking = Booking.new(start_date: Date.today, end_date: Date.today + 3, status: "pending")
booking.boat = alice.owned_boats.first
booking.user = bob
booking.save!

booking = Booking.new(start_date: Date.today, end_date: Date.today + 3, status: "pending")
booking.boat = bob.owned_boats.first
booking.user = alice
booking.save!


