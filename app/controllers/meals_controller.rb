class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :preferences

  def index
    @meals = policy_scope(Meal).where.not(sodium: nil)
    @choice = Choice.new
    # current_user.goal = params[:goal]
    current_user.update(goal: params[:goal])
    case current_user.goal
    when current_user.goal = "healthy"
      if params[:query].present?
        search = @meals.search_by_preferences(params[:query])
        tag = @meals.tagged_with(params[:query])
        join = search + tag
        @results = join.uniq
        @meals = @results.sort_by { |meal| meal.sodium }.first(3)
      else
        @meals = @meals.sort_by { |meal| meal.sodium }.first(3)
        @user = current_user
      end
    when current_user.goal = "lose_weight"
      if params[:query].present?
        search = @meals.search_by_preferences(params[:query])
        tag = @meals.tagged_with(params[:query])
        join = search + tag
        @results = join.uniq
        @meals = @results.sort_by { |meal| meal.calories }.first(3)
      else
        @meals = @meals.sort_by { |meal| meal.calories }.first(3)
        @user = current_user
      end
    when current_user.goal = "gain_muscle"
      if params[:query].present?
        search = @meals.search_by_preferences(params[:query])
        tag = @meals.tagged_with(params[:query])
        join = search + tag
        @results = join.uniq
        @meals = @results.sort_by { |meal| -meal.proteins }.first(3)
      else
        @meals = @meals.sort_by { |meal| -meal.proteins }.first(3)
        @user = current_user
      end
    when current_user.goal = "gain_weight"
      if params[:query].present?
        search = @meals.search_by_preferences(params[:query])
        tag = @meals.tagged_with(params[:query])
        join = search + tag
        @results = join.uniq
        @meals = @results.sort_by { |meal| -meal.fat }.first(3)
      else
        @meals = @meals.sort_by { |meal| -meal.fat }.first(3)
        @user = current_user
      end
    else
      if params[:query].present?
        search = @meals.search_by_preferences(params[:query])
        tag = @meals.tagged_with(params[:query])
        join = search + tag
        @results = join.uniq
        @meals = @results.sort_by { |meal| meal.sodium }.first(3)
      else
        @meals = @meals.sort_by { |meal| meal.sodium }.first(3)
        @user = current_user
      end
    end
    @locations = Location.joins(:meals).where(meals: { id: @meals })
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        # image_url: helpers.asset_url('<%= cl_image_path location.restaurant.photo.key %>')
        # image_url: helpers.asset_url('<%= cl_image_path restaurant.photo.key %>')
        image_url: helpers.cl_image_path(location.restaurant.photo.key)
        # image_url: helpers.asset_url('<%= location.restaurant.logo_url %>')
      }
    end
    @current_position =
    {
      lat: params['lat'].to_f,
      lng: params['lon'].to_f,
      image_url: helpers.asset_url('user_position.png')
    }
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
