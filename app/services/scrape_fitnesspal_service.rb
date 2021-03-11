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
        p meal_name
        meal_url = element.search(".jss64").first.children.first.attribute("href").value
        tag = "drinks" if /.+\soz.*/.match(element.search(".jss65").first.text.strip)
        meal_html = open(short_html + meal_url).read
        meal_doc = Nokogiri::HTML(meal_html, nil, "utf-8")
        calories = meal_doc.search(".title-cgZqW").first.text.strip
        proteins = meal_doc.search(".jss95.jss97.jss96 span").first.text.strip
        p meal_doc.search(".col-1l9Z4 .jss95").count
        attrs = {}
        meal_doc.search(".col-1l9Z4 .jss95").each do |element|
          p element.text.strip
          if element.text.strip.include?("Fat")
            attrs[:fat] = element.search("span").first.text.strip.to_i

          end
          attrs[:carbs] = element.search("span").first.text.strip.to_i if element.text.strip.include?("Carbs")
          attrs[:sodium] = element.search("span").first.text.strip.to_i if element.text.strip.include?('Sodium')
        end
        p attrs
        meal = Meal.create(
          name: meal_name,
          restaurant: Restaurant.find_by(name: restaurant),
          calories: calories,
          proteins: proteins,
          fat: attrs[:fat],
          carbohydrates: attrs[:carbs],
          sodium: attrs[:sodium],
          tag_list: tag
          )
        if meal.tag_list == "Drinks"
          meal.score = meal.drink_score
        else
          meal.score = meal.food_score
        end
        meal.save
        results << meal
      end
    results

    end
  end
end
