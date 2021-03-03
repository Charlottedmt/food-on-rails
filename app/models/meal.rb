class Meal < ApplicationRecord
  belongs_to :restaurant
  has_many :locations, through: :restaurants
  validates :name, presence: true
  validates :price, presence: true
  validate :validate_attrlist
  acts_as_taggable_on :tags
  has_one_attached :photo


  include PgSearch::Model
  pg_search_scope :search_by_preferences,
    against: :name,
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def validate_attrlist
    if calories.blank? && proteins.blank? && carbohydrates.blank? && fat.blank? && sodium.blank?
      errors[:nutrition_infos] << "Can't be blank"
    end
  end

end
