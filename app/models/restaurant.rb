class Restaurant < ApplicationRecord
  CATEGORIES = []
  has_many :meals
  validates :name, presence: true
  validates :address, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
