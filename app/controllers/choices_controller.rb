class ChoicesController < ApplicationController
  def index
    @choices = Choice.all
  end

  def show
    @choice = Choice.find(params[:id])
  end

  def new
    @meal = Meal.find(params[:meal_id])
    @choice = Choice.new
  end

  def create
    @meal = Meal.find(params[:meal_id])
    @choice = Choice.new(choices_params)
    authorize @choice
    if @choice.save
      redirect_to dashboard_path(choice_id: @choice, lat: params[:lat], lon: params[:lon])
    else
      render :new
    end
  end

  def edit
  end

  def update
    @choice = Choice.find(params[:id])
    @choice.update(choices_params)
    authorize @choice
    redirect_to root_path
  end

  def choices_params
    params.require(:choice).permit(:meal_id, :user_id, :rating)
  end
end
