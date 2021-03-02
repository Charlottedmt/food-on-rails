class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :preferences

  def index
    @meals = Meal.all
    array1 = []
    array2 = []
    array3 = array1 + array2
    @meals = array3.distinct

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
    params.require(:meal).permit(:name, :price, :calories, :protein, :fat, :carbohydrates, :sodium, tag_list: [])
  end

end
