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
    raise
  end

  def create
    @meal = Meal.find(params[:meal_id])
    @choice = Choice.new(choices_params)
    authorize @choice
    if @choice.save
      redirect_to dashboard_path(choice_id: @choice)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @choice = Choice.find(params[:id])
    @choice.update(choices_params)
    redirect_to dashboard_path
  end

  def choices_params
    params.require(:choice).permit(:meal_id, :user_id, :rating)
  end
end
