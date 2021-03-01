class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: :dashboard
  def dashboard
  end
end
