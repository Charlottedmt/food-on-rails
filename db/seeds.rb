# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ../lib/assets/nutrition_info.csv
# Create a hash with restaurant name as key, and address as value
# e.g. addresses = { key: "Coco Ichibanya": address, value: "1-4-9 Meguro, Meguro City, Tokyo" }
require 'csv'
require "open-uri"
puts "Destroying all restaurants & meals..."
Restaurant.destroy_all
# Meal.destroy_all

restaurants = {
  "Coco Ichibanya" => ["1-4-9 Meguro, Meguro City, Tokyo"],
  "Seven Eleven" => ["2-2-11 Shimomeguro, Meguro City, Tokyo", "1-3-1 Shimomeguro, Meguro City, Tokyo"],
  "McDonalds" => ["2-12-19 Yutenji, Meguro City, Tokyo"],
  "Starbucks" => ["2-16-9 Kamiosaki, Shinagawa City, Tokyo"],
  "Lawson" => ["3-9-1 Meguro, Meguro City, Tokyo", "1-5-19 Meguro, Meguro City, Tokyo"],
  "Yoshinoya" => ["2-27-2 Kamiosaki, Shinagawa, Tokyo"],
  "Sukiya" => ["3-9-3 Meguro, Meguro City, Tokyo"],
  "Mos Burger" => [ "2−17−3 Kamiosaki, Shinagawa City, Tokyo"],
  "Family Mart" => ["3-10-13 Meguro, Meguro City, Tokyo"],
  # not actual restauraunt addresses from here, just close to HUB
  "Denny's" => ["2−11−9 Meguro, Meguro City, Tokyo"],
  "Burger King" => ["2−11−8 Meguro, Meguro City, Tokyo"],
  "Freshness Burger" => ["2-10-4 Meguro, Meguro City, Tokyo"]
}
#creating the restaurant
restaurants.each do |restaurant, addresses|
  Restaurant.create!(name: restaurant)
end
#creating the locations ofr each restaurant
Restaurant.all.each do |restaurant|
  next unless restaurants.key?(restaurant.name) #skip
  restaurants[restaurant.name].each do |address|
    Location.where(address: address, restaurant: restaurant).first_or_create!
  end
end

#giving a logo to each restaurant
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'lib/restaurant_logo.csv'
CSV.foreach(filepath, csv_options) do |row|
  puts "Finding restaurant...thanks to Doug's advice..."
  restaurant = Restaurant.where(name: row['Restaurant']).first #.first_or_create!
  p restaurant
#   puts "#{restaurant.name}"
#   p row['logo_url']
#   puts ""
  unless restaurant.photo.attached?
    restaurant_file = URI.open(row['logo_url'])
    logo_regex_jpg = /jpg/
    logo_regex_png = /png/
    if logo_regex_jpg.match(row['logo_url'])
      logo_photo_filename = 'nes.jpg'
      logo_photo_content_type = 'image/jpg'
    elsif logo_regex_png.match(row['logo_url'])
      logo_photo_filename = 'nes.png'
      logo_photo_content_type = 'image/png'
    else
      logo_photo_filename = 'nes.svg'
      logo_photo_content_type = 'image/svg'
    end
    restaurant.photo.attach(io: restaurant_file, filename: logo_photo_filename, content_type: logo_photo_content_type)
  end
end

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'lib/nutrition_info.csv'
CSV.foreach(filepath, csv_options) do |row|
  puts "Finding restaurant...thanks to Doug's advice..."
  restaurant = Restaurant.where(name: row['Restaurant']).first
    # if statement to assign correct value for filename & content_type
    p row['Image_url']
    file = URI.open(row['Image_url'])
    regex_jpg = /jpg/
    if regex_jpg.match(row['Image_url'])
      photo_filename = 'nes.jpg'
      photo_content_type = 'image/jpg'
    else
    photo_filename = 'nes.png'
    photo_content_type = 'image/png'
  end
  puts "Creating meal..."
  meal = Meal.new(
    name: row['Meal'],
    calories: row['Calories'],
    proteins: row['Protein'],
    fat: row['Fat'],
    carbohydrates: row['Carbohydrates'],
    sodium: row['Sodium'],
    price: row['Price'],
    score: row['Food Score'],
    tag_list: row['Tags'],
    photo: row['Image_url']
  )
  meal.restaurant = restaurant
  meal.photo.attach(io: file, filename: photo_filename, content_type: photo_content_type)
  meal.save!
  puts "Creating meal #{meal.id}..."
end
puts "Retrieving Address Log..."


puts "Creating default user..."
admin = User.first_or_create!(
  email: "admin@foodonrails.com",
  password: "password",
  admin: true
)
puts "User created and retrieving last month's data..."

udon = Meal.create!(name: "Charlotte Brownie", restaurant: Restaurant.first, calories: 24, proteins: 25, carbohydrates: 2, fat: 23, sodium: 12)
p udon
4.times do
  Choice.create!(
    user: admin,
    meal: udon
  )
end

Choice.all.each do |choice|
  choice.created_at = Date.new(2021, 02, 01)
  choice.save!
end
puts "Last month's choices retrieved"
# After restaurants are created, insert the value into the approriate key
# e.g. Cocoichiban has address "123 Address", so if restaurant is created with name "Cocoichiban", then insert address into it
puts "All meals added!"
