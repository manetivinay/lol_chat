class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = 'welcome back'
        redirect_to user_path(@user.id)
      else
        flash[:error] = 'wrong password'
        redirect_to new_session_path
      end
    else
      flash[:error] = 'Email not Found'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'Logged out'
    redirect_to root_path
  end
end
