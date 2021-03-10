module CalorieScoreHelper
  def calories_cutoff_score(calories)
    @cutoff_score = 0
    if calories > 10
      return @cutoff_score + 10
    elsif calories < 2
      return @cutoff_score
    else
      return @cutoff_score + 5
    end
  end

  def calories_bonus_score(calories)
    @bonus_score = 0
    if (2..10).cover?(calories)
      if calories - 2 < 6
        return @bonus_score + (calories - 2)
      else
        return @bonus_score + 5
      end
    elsif calories > 10
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end
end
