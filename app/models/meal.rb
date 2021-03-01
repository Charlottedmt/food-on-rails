class Meal < ApplicationRecord
  belongs_to :restaurant
  validates :name, presence: true
  validates :price, presence: true
  validate :validate_attrlist

  def validate_attrlist
    if calories.blank? && proteins.blank? && carbohydrates.blank? && fat.blank? && sodium.blank?
       errors[:nutrition_infos] << "Can't be blank"
    end
  end

end
