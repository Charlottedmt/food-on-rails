require "open-uri"
require "nokogiri"
# require_relative "meal"

class ScrapeFitnesspalService
  def initialize
    @restaurants = ['Coco Ichibanya','Seven Eleven','McDonalds','Starbucks', 'Lawson', 'Yoshinoya', 'Sukiya', 'Mos Burger', 'Family Mart', "Denny's", 'Burger King', 'Freshness Burger' ]
  end

  def call
    @restaurants.each do |restaurant|
      html = open("https://www.myfitnesspal.com/food/search?page=1&search=#{restaurant}").read
      short_html = "https://www.myfitnesspal.com"
      # 1. Parse HTML
      doc = Nokogiri::HTML(html, nil, "utf-8")
      # 2. For the first five results
      results = []
      doc.search(".jss60").each do |element|
        # 3. Create recipe and store it in results
        meal_name = element.search(".jss64").first.text.strip
        meal_url = element.search(".jss64").first.children.first.attribute("href").value
        tag = "drinks" if /.+\soz.*/.match(element.search(".jss65").first.text.strip)
        meal_html = open(short_html + meal_url).read
        meal_doc = Nokogiri::HTML(meal_html, nil, "utf-8")
        calories = meal_doc.search(".title-cgZqW").first.text.strip
        proteins = meal_doc.search(".jss95.jss97.jss96 span").first.text.strip
        case meal_doc.search(".jss95.jss96").first.text.strip
        when "Fat"
          fat = meal_doc.search(".jss95.jss96 span").first.text.strip
        when "Carbs"
          carbs = meal_doc.search(".jss95.jss96 span").first.text.strip.to_i
        end
        sodium = meal_doc.search(".jss95 span").first.text.strip.to_i if meal_doc.search(".jss95").first.text.strip.to_i == 'Sodium'
        results << Meal.create!(
          name: meal_name,
          restaurant: Restaurant.find_by(name: restaurant),
          calories: calories,
          proteins: proteins,
          fat: fat,
          carbohydrates: carbs,
          sodium: sodium
          )
      end
    results

    end
  end
end
