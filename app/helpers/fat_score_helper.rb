module FatScoreHelper
  def fat_cutoff_score(fat)
    @cutoff_score = 0
    if fat > 10
      return @cutoff_score + 10
    elsif fat < 2
      return @cutoff_score
    else
      return @cutoff_score + 5
    end
  end

  def fat_ratio_score(fat, calories)
    @ratio_score = 0
    if ((fat * 4) / calories) * 100 > 35
      return @ratio_score + 5
    elsif ((fat * 4) / calories) * 100 < 10
      return @ratio_score
    else
      return @ratio_score + 10
    end
  end

  def fat_bonus_score(fat)
    @bonus_score = 0
    if (2..10).cover?(fat)
      if fat - 2 < 6
        return @bonus_score + (fat - 2)
      else
        return @bonus_score + 5
      end
    elsif fat > 10
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end
end
