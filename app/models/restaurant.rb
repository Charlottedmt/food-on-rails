class Restaurant < ApplicationRecord
  CATEGORIES = []
  has_many :meals, dependent: :destroy
  has_many :locations, dependent: :destroy
  validates :name, presence: true
  has_one_attached :photo
  # validates :address, presence: true
  # validates :category, inclusion: { in: CATEGORIES }
end
