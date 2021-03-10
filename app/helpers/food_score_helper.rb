module FoodScoreHelper

  def protein_cutoff_score

      if meal.proteins > 30
        @protein_cutoff_score + 10
      elsif meal.proteins < 10
        @protein_cutoff_score
      else
        @protein_cutoff_score + 5
      end
  end

  def protein_ratio_score
    @protein_ratio_score = 0

    if ((meal.proteins * 4) / meal.calories) * 100 > 35
      @protein_ratio_score + 5
    elsif ((meal.proteins * 4) / meal.calories) * 100 < 10
      @protein_ratio_score
    else
      @protein_ratio_score + 10
    end
  end

  def protein_bonus_score

  end

  def proteins_score
    protein_cutoff_score + protein_ratio_score + protein_bonus_score
  end

  def score
    @calorie_score + @fat_score + @sodium_score + @carbohydrates_score + @proteins_score
  end
end
