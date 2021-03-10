namespace :meal do
  desc "Scrapping My fitness pal website"
  task scrape: :environment do
    ScrapeFitnesspalService.new.call
  end

end
