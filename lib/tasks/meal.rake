namespace :meal do
  desc "Attaching photos from Lorum flicker"
  task add_photos: :environment do
    Meal.find_each do |meal|
      next if meal.photo.attached? || !meal.name.match?(/^[\x00-\x7F]*$/)

      puts "Adding photos for #{meal.name}"
      file = URI.open("http://loremflickr.com/200/200/#{meal.name.split.join}")
      meal.photo.attach(io: file, filename: 'meal.jpg', content_type: 'image/jpg')
      meal.save!
    end
  end

  desc "Scrapping My fitness pal website"
  task scrape: :environment do
    ScrapeFitnesspalService.new.call
  end

end
