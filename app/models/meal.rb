class Meal < ApplicationRecord
  belongs_to :restaurant
  validates :name, presence: true
  validates :price, presence: true
  validates :validate_attrlist

  def validate_attrlist
    unless !calories.blank? || !proteins.blank? || !carbohydrates.blank? || !fat.blank? || !sodium.blank?
       record.errors[:base] << "Can't be blank"
    end
  end

end
