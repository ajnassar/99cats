class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to cats_url
    else
      flash.now[:errors] = "Invalid username or password"
      render :new
    end
  end
end
