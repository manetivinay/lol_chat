class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to received_messages_path, flash: {success: 'welcome back'}
      else
        redirect_to new_session_path, notice: 'wrong password'
      end
    else
      redirect_to new_session_path, notice: 'Email not Found'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out..'
  end
end
