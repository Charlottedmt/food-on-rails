class Location < ApplicationRecord
  belongs_to :restaurant
  has_many :meals, through: :restaurant

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
