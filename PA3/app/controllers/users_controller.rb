class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    require_login
    @user = User.find(params[:id])
    @courses = current_user.courses
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
