class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(*params[:user].values)
    if @user.nil?
      flash.now[:errors] = "No username or password"
      render :new
    else
      @user.reset_session_token!
      @user.save!
      redirect_to cats_url
    end
  end

  def new
    render :new
  end
end
