module CarbScoreHelper
  def carb_cutoff_score(carb)
    @cutoff_score = 0
    if carb > 10
      return @cutoff_score + 10
    elsif carb < 2
      return @cutoff_score
    else
      return @cutoff_score + 5
    end
  end

  def carb_ratio_score(carb, calories)
    @ratio_score = 0
    if ((carb * 4) / calories) * 100 > 35
      return @ratio_score + 5
    elsif ((carb * 4) / calories) * 100 < 10
      return @ratio_score
    else
      return @ratio_score + 10
    end
  end

  def carb_bonus_score(carb)
    @bonus_score = 0
    if (2..10).cover?(carb)
      if carb - 2 < 6
        return @bonus_score + (carb - 2)
      else
        return @bonus_score + 5
      end
    elsif carb > 10
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end
end
