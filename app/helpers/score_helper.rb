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

  def get_score_background(score)
    if score > 70
      return "rgba(152, 224, 154, 0.2)"
    elsif (51..70).cover?(score)
      return "rgba(244, 240, 195, 0.9)"
    else
      return "rgba(237, 83, 85,0.2)"
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
        return "+#{(current_month - last_month).round(2)} points"
      else
        return "#{(current_month - last_month).round(2)} points"
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
        return "+#{(current_month - nationwide).round(2)} points"
      else
        return "#{(current_month - nationwide).round(2)} points"
      end
    end
  end

  def get_score_color(current_month, last_month)
    return "white" if current_month.nil? || last_month.nil?

    if (current_month - last_month).positive?
      return "rgb(152, 224, 154)"
    else
      return "rgb(237, 83, 85)"
    end
  end
  def get_score_bg_color(current_month, last_month)
    return "white" if current_month.nil? || last_month.nil?

    if (current_month - last_month).positive?
      return "rgba(152, 224, 154, 0.2)"
    else
      return "rgba(237, 83, 85,0.2)"
    end
  end
end
