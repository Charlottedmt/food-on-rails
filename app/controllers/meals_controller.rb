class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :preferences
  def index
    @meals = policy_scope(Meal)
    if params[:query].present?
      @meals = Meal.search_by_preferences(params[:query]).first(3)
    else
      @meals = Meal.first(3)
    end
  end

  def show
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to meals_path
    else
      render :new
    end
  end

  def preferences
    skip_authorization
  end

  def meal_params
    params.require(:meal).permit(:name, :price, :calories, :protein, :fat, :carbohydrates, :sodium)
  end
end
