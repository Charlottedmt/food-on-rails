class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # authorize @user
  end

  def edit
    @user = User.find(params[:id])
    # authorize @user
  end

  # not sure if we need this!
  def update
    @user = User.find(params[:id])
    # authorize @user
    if @user.update(user_params)
      redirect_to dashboard_path 'Profile was successfully updated' #set redirect to render
    else
      render :edit # not sure of the render yet
    end
  end

  def user_params
    params.require(:user).permit(:username, :height, :weight, :goal)
  end
end
