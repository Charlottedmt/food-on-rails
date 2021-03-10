module SodiumScoreHelper
  def sodium_cutoff_score(sodium)
    @cutoff_score = 0
    if sodium > 10
      return @cutoff_score + 10
    elsif sodium < 2
      return @cutoff_score
    else
      return @cutoff_score + 5
    end
  end

  def sodium_ratio_score(sodium, calories)
    @ratio_score = 0
    if ((sodium * 4) / calories) * 100 > 35
      return @ratio_score + 5
    elsif ((sodium * 4) / calories) * 100 < 10
      return @ratio_score
    else
      return @ratio_score + 10
    end
  end

  def sodium_bonus_score(sodium)
    @bonus_score = 0
    if (2..10).cover?(sodium)
      if sodium - 2 < 6
        return @bonus_score + (sodium - 2)
      else
        return @bonus_score + 5
      end
    elsif sodium > 10
      return @bonus_score + 10
    else
      return @bonus_score
    end
  end
end
