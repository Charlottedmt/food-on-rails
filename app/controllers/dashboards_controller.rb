class DashboardsController < ApplicationController
  skip_after_action :verify_authorized, only: :dashboard

  def dashboard
    @current_position =
    {
      lat: params['lat'].to_f,
      lng: params['lon'].to_f,
    }
    if params[:choice_id].present?
      @choice = Choice.find(params[:choice_id])
    end
    @choices = policy_scope(Choice)
    @average_score = current_user.meals.where(choices: {created_at: Time.current.beginning_of_month..Time.current.end_of_month}).average(:score)
    @last_month = current_user.meals.where(choices: {created_at: (Time.current.beginning_of_month - 1.month)..(Time.current.end_of_month - 1.month)}).average(:score)
  end
end
