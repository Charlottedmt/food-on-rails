module FoodScoreHelper
  def protein_cutoff_score(protein)
    @cutoff_score = 0
    if protein > 10
      return @cutoff_score + 10
    elsif protein < 2
      return @cutoff_score
    else
      return @cutoff_score + 5
    end
  end

  def protein_ratio_score(protein, calories)
    @ratio_score = 0
    if ((protein * 4) / calories) * 100 > 35
      return @ratio_score + 5
    elsif ((protein * 4) / calories) * 100 < 10
      return @ratio_score
    else
      return @ratio_score + 10
    end
  end

  def protein_bonus_score(protein)
    @bonus_score = 0
    if (2..10).cover?(protein)
      if protein - 2 < 6
        return @bonus_score + (protein - 2)
      else
        return @bonus_score + 5
      end
    elsif protein > 10
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end

  def get_score_class(score)
    if score > 70
      return "score-success"
    elsif (51..70).cover?(score)
      return "score-warning"
    else
      return "score-danger"
    end
  end

  def score
    @calorie_score + @fat_score + @sodium_score + @carbohydrates_score + @proteins_score
  end
end
