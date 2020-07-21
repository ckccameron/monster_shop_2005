class UsersController < ApplicationController
  def new
  end

  def create
    redirect_to '/profile'
  end

  def show
    flash[:success] = "You are now registered and logged in"
  end
end
