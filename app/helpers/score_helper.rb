module ScoreHelper
  def get_alert_class(status)
    case status
    when "pending"
      return "flash-warning"
    when "confirmed"
      return "flash-success"
    when "rejected"
      return "flash-danger"
    end
  end
end

# <%= get_alert_class(booking.status) %>
