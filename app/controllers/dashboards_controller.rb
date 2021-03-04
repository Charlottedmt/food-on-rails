class DashboardsController < ApplicationController
  skip_after_action :verify_authorized, only: :dashboard

  def dashboard
    if params[:choice_id].present?
      @choice = Choice.find(params[:choice_id])
    end
    @choices = policy_scope(Choice)
  end
end
