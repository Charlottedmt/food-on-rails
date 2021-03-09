class DashboardsController < ApplicationController
  skip_after_action :verify_authorized, only: :dashboard

  def dashboard
    @current_position =
      {
        lat: params['lat'].to_f,
        lng: params['lon'].to_f
      }
    @choice = Choice.find(params[:choice_id]) if params[:choice_id].present?
    @choices = policy_scope(Choice)
  end

  def calculate
  end
end
