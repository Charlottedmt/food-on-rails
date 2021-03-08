class Meal < ApplicationRecord
  belongs_to :restaurant
  has_many :locations, through: :restaurant
  has_many :choices, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validate :validate_attrlist
  acts_as_taggable_on :tags
  has_one_attached :photo
  scope :max_calories_meal, -> { order(calories: :desc).first }
  scope :max_fat_meal, -> { order(fat: :desc).first }
  scope :max_sodium_meal, -> { order(sodium: :desc).first }
  scope :min_protein_meal, -> { order(proteins: :asc).first }

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

  def calorie_cutoffs
  case calories
  when 0...400 then :'#246A73'
  when 400..600 then :'#E87EA1'
  when 600..1000 then :'#F8F32B'
  end
  end

  def protein_cutoffs
  end

  def fat_cutoffs
  end

  def sodium_cutoffs
  end

  def carbs_cutoffs
  end
end