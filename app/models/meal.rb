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

  # Food on Rails top secret special food score algorithm

  # CALORIES
  def calories_cutoff_score
    @cutoff_score = 0
    if calories < 400
      return @cutoff_score + 20
    elsif calories > 800
      return @cutoff_score
    else
      return @cutoff_score + 10
    end
  end

  # CARBOHYDRATES
  def carb_ratio_score
    @ratio_score = 0
    if ((carbohydrates * 4) / calories) * 100 > 65
      return @ratio_score
    elsif ((carbohydrates * 4) / calories) * 100 < 45
      return @ratio_score + 5
    else
      return @ratio_score + 10
    end
  end

  def carb_bonus_score
    @bonus_score = 0
    if (30..50).cover?(carbohydrates)
      if 50 - carbohydrates < 10
        return @bonus_score + ((50 - carbohydrates) / 2)
      else
        return @bonus_score + 5
      end
    elsif carbohydrates > 50
      return @bonus_score
    else
      return @bonus_score + 10
    end
  end

  def carb_score
    return carb_bonus_score + carb_ratio_score
  end

  # FAT
  def fat_ratio_score
    @ratio_score = 0
    if ((fat * 9) / calories) * 100 > 35
      return @ratio_score
    elsif ((fat * 9) / calories) * 100 < 20
      return @ratio_score + 5
    else
      return @ratio_score + 10
    end
  end

  def fat_bonus_score
    @bonus_score = 0
    if (10..20).cover?(fat)
      if 20 - fat < 5
        return @bonus_score + (20 - fat)
      else
        return @bonus_score + 5
      end
    elsif fat < 10
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end

  def fat_score
    return fat_bonus_score + fat_ratio_score
  end

  # PROTEIN
  def protein_ratio_score
    @ratio_score = 0
    if ((proteins * 4) / calories) * 100 < 10
      return @ratio_score
    elsif ((proteins * 4) / calories) * 100 > 35
      return @ratio_score + 5
    else
      return @ratio_score + 10
    end
  end

  def protein_bonus_score
    @bonus_score = 0
    if (10..20).cover?(proteins)
      if proteins - 10 < 5
        return @bonus_score + (proteins - 10)
      else
        return @bonus_score + 5
      end
    elsif proteins > 20
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end

  def protein_score
    return protein_bonus_score + protein_ratio_score
  end

  # SODIUM
  def sodium_cutoff_score
    @cutoff_score = 0
    if sodium < 1.5
      return @cutoff_score + 20
    elsif sodium > 2.5
      return @cutoff_score
    else
      return @cutoff_score + 10
    end
  end

  # TOTAL SCORE
  def food_score
    (sodium_cutoff_score + calories_cutoff_score + carb_score + protein_score + fat_score).round
  end
end
