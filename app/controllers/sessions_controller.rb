class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(*params[:user].values)
    if @user.nil?
      flash.now[:errors] = "No username or password"
      render :new
    else
      @user.reset_session_token!
      login_user!(@user)
      redirect_to cats_url
    end
  end

  def new
    render :new
  end

  def destroy
    user = User.find_by_session_token(session[:session_token])
    session[:session_token] = nil
    user.reset_session_token!
    redirect_to new_session_url
  end
end
