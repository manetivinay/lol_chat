class UsersController < ApplicationController
  def index
    # Rails.logger.info requst.enc["HTTP_COKIE"]
    @users = User.all
  end

  def new
    @user = User.new
  end


  def welcome

  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path, notice: 'Thanks you for signing up! you are now logged in.'
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
