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
    @average_score = current_user.meals.where(choices: { created_at: Time.current.beginning_of_month..Time.current.end_of_month }).average(:score)
    @last_month = current_user.meals.where(choices: { created_at: (Time.current.beginning_of_month - 1.month)..(Time.current.end_of_month - 1.month) }).average(:score)
  end

  def numbers_total(choices)
    @calories = 0
    @fat = 0
    @sodium = 0
    @carbohydrates = 0
    @proteins = 0

    choices_array = choices.each do |choice|
      @calories += choice.meal.calories
      @fat += choice.meal.fat
      @sodium += choice.meal.sodium
      @carbohydrates += choice.meal.carbohydrates
      @proteins += choice.meal.proteins
    end
    equivalence(@calories, @fat, @sodium, @carbohydrates, @proteins)
  end

  def equivalence(calories, fat, sodium, carbohydrates, proteins)
    @bike = ((calories / 300) * 30).round(1)
    @pizza = fat / 50
    @bread = carbohydrates / 15
    @egg = (proteins / 6).round(1)
    @salt = (sodium / 2.3).round(1)
  end
end
