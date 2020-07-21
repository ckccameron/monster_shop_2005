class UsersController < ApplicationController
  def new
  end

  def create
    redirect_to '/profile'
  end
end
