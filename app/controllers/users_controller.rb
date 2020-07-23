class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to '/profile'
      flash[:success] = "You are now registered and logged in"
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  def show
    render file: "/public/404" if !current_user
  end

  private
  def user_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :email,
                  :password,
                  :role)
  end
end
