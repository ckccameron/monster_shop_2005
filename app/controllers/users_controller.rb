class UsersController < ApplicationController
  def new
  end

  def create
    #require "pry"; binding.pry
    user = User.create(user_params)
    session[:user_id] = user.id
    if user.save
      redirect_to '/profile'
      flash[:success] = "Logged in as #{user.name}"
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  def show
    #require "pry"; binding.pry
    @user = User.find(session[:user_id])
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
