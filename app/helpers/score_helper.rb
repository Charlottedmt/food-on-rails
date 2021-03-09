module ScoreHelper
  def get_score_class(score)
    if score > 70
      return "score-success"
    elsif (51..70).cover?(score)
      return "score-warning"
    else
      return "score-danger"
    end
  end
  def get_score_icon(score)
    if score > 70
      return "caret-up"
    elsif (51..70).cover?(score)
      return "minus small align-middle"
    else
      return "caret-down"
    end
  end

  def get_dashboard_score(last_month, current_month)
    # if last month doesn't exist, return nil
    return "No data yet" if last_month.nil? || current_month.nil?
    # subtract current month and last month
    if (current_month - last_month) == -1 || (current_month - last_month) == 1
      return "#{current_month - last_month} point"
    else
      if (current_month - last_month).positive?
        return "+#{current_month - last_month} points"
      else
        return "#{current_month - last_month} points"
      end
    end
  end

  def get_dashboard_arrow(current_month, last_month)
    return "fa-minus" if current_month.nil? || last_month.nil?

    if (current_month - last_month).positive?
      return "fa-long-arrow-alt-up"
    else
      return "fa-long-arrow-alt-down"
    end
  end
  def get_nationwide_arrow(current_month, nationwide)
    return "fa-minus" if current_month.nil?

    if (current_month - nationwide).positive?
      return "fa-long-arrow-alt-up"
    else
      return "fa-long-arrow-alt-down"
    end
  end
  def get_nationwide_score(current_month, nationwide)
    # if last month doesn't exist, return nil
    return "No data yet" if current_month.nil?
    # subtract current month and last month
    if (current_month - nationwide) == -1 || (current_month - nationwide) == 1
      return "#{current_month - nationwide} point"
    else
      if (current_month - nationwide).positive?
        return "+#{current_month - nationwide} points"
      else
        return "#{current_month - nationwide} points"
      end
    end
  end
end
