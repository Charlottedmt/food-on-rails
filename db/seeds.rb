# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ../lib/assets/nutrition_info.csv

require 'csv'

puts "Destroying all restaurants & meals..."

Restaurant.destroy_all

Meal.destroy_all

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

puts "All meals added!"
