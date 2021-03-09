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
Meal.destroy_all
addresses = {
  "Coco Ichibanya" => ["1-4-9 Meguro, Meguro City, Tokyo"],
  "Seven Eleven" => ["2-2-11 Shimomeguro, Meguro City, Tokyo"],
  "McDonalds" => ["2-12-19 Yutenji, Meguro City, Tokyo"],
  "Starbucks" => ["2-16-9 Kamiosaki, Shinagawa City, Tokyo"],
  "Lawson" => ["3-9-1 Meguro, Meguro City, Tokyo"],
  "Yoshinoya" => ["2-27-2 Kamiosaki, Shinagawa, Tokyo"],
  # not actual restauraunt addresses from here, just close to HUB
  "Denny's" => ["2−11−9 Meguro, Meguro City, Tokyo"],
  "Burger King" => ["2−11−8 Meguro, Meguro City, Tokyo"],
  "Freshness Burger" => ["2-10-4 Meguro, Meguro City, Tokyo"]
}
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'lib/nutrition_info.csv'
CSV.foreach(filepath, csv_options) do |row|
  puts "Finding restaurant...thanks to Doug's advice..."
  restaurant = Restaurant.where(name: row['Restaurant']).first_or_create!
  puts "Creating meal..."
  file = URI.open(row['Image_url'])
  restaurant_file = URI.open(row['logo_url'])
  # if statement to assign correct value for filename & content_type
  regex_jpg = /jpg/
  if regex_jpg.match(row['Image_url'])
    photo_filename = 'nes.jpg'
    photo_content_type = 'image/jpg'
  else
    photo_filename = 'nes.png'
    photo_content_type = 'image/png'
  end

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
  restaurant.photo.attach(io: restaurant_file, filename: logo_photo_filename, content_type: logo_photo_content_type)
  meal.save!
end
puts "Retrieving Address Log..."
Restaurant.all.each do |restaurant|
  next unless addresses.key?(restaurant.name) #skip
  addresses[restaurant.name].each do |address|
    Location.where(address: address, restaurant: restaurant).first_or_create!
  end
end
# After restaurants are created, insert the value into the approriate key
# e.g. Cocoichiban has address "123 Address", so if restaurant is created with name "Cocoichiban", then insert address into it
puts "All meals added!"
