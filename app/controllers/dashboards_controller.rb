class DashboardsController < ApplicationController
  skip_after_action :verify_authorized, only: :dashboard

  def dashboard
    @choices = policy_scope(Choice)
  end
end
