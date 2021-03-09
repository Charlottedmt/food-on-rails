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

  def get_dashboard_score(score)
  end
end

# <%= get_alert_class(booking.status) %>
