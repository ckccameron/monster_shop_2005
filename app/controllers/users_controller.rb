class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to '/profile'
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  def show
    flash[:success] = "You are now registered and logged in"
  end

  private
  def user_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :email,
                  :password)
  end
end
