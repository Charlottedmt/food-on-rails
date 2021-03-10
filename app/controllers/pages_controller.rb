class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  
  def home
    @meals = Meal.all
    @choice = current_user&.choices.order(created_at: :desc).first if current_user
  end
  # & = if current user is nil it wont call user choices
end
