# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: "Luka", email: "lukahorvat@example.com", password: "123456")
Boat.create(name: "Marina", price: 150, description: "famous", location: "Port of Brac", user_id: 1,)
Boat.create(name: "Novi Sad", price: 190, description: "luxury", location: "Port of Budva",user_id: 1,)
Boat.create(name: "Black Pearl", price: 140, description: "party", location: "Port of London", user_id: 1,)
Boat.create(name: "Titanic", price: 90, description: "dead", location: "Port of Liverpool", user_id: 1,)