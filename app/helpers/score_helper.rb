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
    return "No data yet" if !last_month
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
  def get_dashboard_arrow(last_month, current_month)
    return "fa-minus" if !last_month

    if (current_month - last_month).positive?
      return "fa-long-arrow-alt-up"
    else
      return "fa-long-arrow-alt-down"
    end
  end
end
