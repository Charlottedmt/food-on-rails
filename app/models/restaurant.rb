class Restaurant < ApplicationRecord
  CATEGORIES = []
  has_many :meals, dependent: :destroy
  has_many :locations
  validates :name, presence: true
  # validates :address, presence: true
  # validates :category, inclusion: { in: CATEGORIES }
end
