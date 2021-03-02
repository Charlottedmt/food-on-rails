class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :preferences
  def index
    if params[:query].present?
      @meals = Movie.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @meals = Meals.all
    end
  end


  def show
    @meal = Meal.find(params[:id])
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
  end

  def meal_params
    params.require(:meal).permit(:name, :price, :calories, :protein, :fat, :carbohydrates, :sodium)
  end

end
