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


puts "Destroying all restaurants & meals..."

Restaurant.destroy_all

Meal.destroy_all


addresses = {
  "Coco Ichibanya" => ["1-4-9 Meguro, Meguro City, Tokyo"],
  "Seven Eleven" => ["1 Chome-3-1 Shimomeguro, Meguro City, Tokyo"],
  "McDonalds" => ["2 Chome-15-17 Kamiosaki, Shinagawa City, Tokyo"],
  "Starbucks" => ["2 Chome-16-9 Kamiosaki, Shinagawa City, Tokyo"],
  "Lawson" => ["3 Chome-9-1 Meguro, Meguro City, Tokyo"]
}

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'lib/nutrition_info.csv'

CSV.foreach(filepath, csv_options) do |row|
  puts "Finding restaurant...thanks to Doug's advice..."
  restaurant = Restaurant.where(name: row['Restaurant']).first_or_create!
  puts "Creating meal..."
  meal = Meal.new(
    name: row['Meal'],
    calories: row['Calories'],
    proteins: row['Protein'],
    fat: row['Fat'],
    carbohydrates: row['Carbohydrates'],
    sodium: row['Sodium'],
    price: row['Price'],
    tag_list: row['Tags']
  )
  meal.restaurant = restaurant
  meal.save!
end

puts "Retrieving Address Log..."

Restaurant.all.each do |restaurant|
  next unless addresses.key?(restaurant.name)

  addresses[restaurant.name].each do |address|
    Location.where(address: address, restaurant: restaurant).first_or_create!
  end
end

# After restaurants are created, insert the value into the approriate key
# e.g. Cocoichiban has address "123 Address", so if restaurant is created with name "Cocoichiban", then insert address into it

puts "All meals added!"
