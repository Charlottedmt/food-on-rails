class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @meals = Meal.all
    @choices = current_user.choices
  end
end
