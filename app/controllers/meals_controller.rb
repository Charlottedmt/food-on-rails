class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :preferences

  def index
    @meals = policy_scope(Meal).where.not(sodium: nil)
    @choice = Choice.new
    if params[:tag] == 'Drinks'
      @meals = @meals.tagged_with(params[:tag])
      if params[:query].present?
        @meals = search(@meals, params[:query])
        @meals = @meals.sort_by { |meal| -meal.food_score }.first(3)
      else
        @meals = @meals.sort_by { |meal| -meal.food_score }.first(3)
        @user = current_user
      end
    else
      @meals = @meals.tagged_with('Drinks', exclude: true)
      if params[:query].present?
        @meals = search(@meals, params[:query])
        @meals = @meals.sort_by { |meal| -meal.food_score }.first(3)
      else
        @meals = @meals.sort_by { |meal| -meal.food_score }.first(3)
        @user = current_user
      end
    end
    @current_position =
      {
        lat: params['lat'].to_f,
        lng: params['lon'].to_f,
        image_url: helpers.asset_url('user_position.png')
      }
    @locations = Location.joins(:meals).where(meals: { id: @meals })
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        image_url: helpers.cl_image_path(location.restaurant.photo.key)
      }
    end
  end

  def search(meals, params)
    search = meals.search_by_preferences(params)
    tag = meals.tagged_with(params)
    join = search + tag
    @results = join.uniq
  end

  def show
    @meal = Meal.find(params[:id])
    authorize @meal
    @choice = Choice.new
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
    params.require(:meal).permit(:name, :price, :calories, :protein, :fat, :carbohydrates, :sodium, tag_list: [])
  end
end

# current_user.goal = params[:goal]
# current_user.update(goal: params[:goal])
# case current_user.goal
# when current_user.goal = "lose_weight"
#   if params[:query].present?
#     search = @meals.search_by_preferences(params[:query])
#     tag = @meals.tagged_with(params[:query])
#     join = search + tag
#     @results = join.uniq
#     @meals = @results.sort_by { |meal| meal.calories }.first(3)
#   else
#     @meals = @meals.sort_by { |meal| meal.calories }.first(3)
#     @user = current_user
#   end
