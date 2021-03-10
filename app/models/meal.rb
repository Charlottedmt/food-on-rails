class Meal < ApplicationRecord
  belongs_to :restaurant
  has_many :locations, through: :restaurant
  has_many :choices, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :score, presence: true
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
                  associated_against: {
                    restaurant: :name
                   },
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
    case proteins
    when 0...10 then :'#F40000'
    when 10..20 then :'#FCBA04'
    when 20..1000 then :'#8CD867'
    end
  end

  def fat_cutoffs
    case fat
    when 0...10 then :'#8CD867'
    when 10..20 then :'#FCBA04'
    when 20..1000 then :'#F40000'
    end
  end

  def sodium_cutoffs
    case sodium
    when 0...1.5 then :'#8CD867'
    when 1.5..2.5 then :'#FCBA04'
    when 2.5..100 then :'#F40000'
    end
  end

  def carbs_cutoffs
    case carbohydrates
    when 0...30 then :'#8CD867'
    when 30..50 then :'#FCBA04'
    when 50..1000 then :'#F40000'
    end
  end
end
