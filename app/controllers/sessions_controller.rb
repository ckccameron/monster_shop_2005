class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id

      if user.role == "default"
        redirect_to '/profile'
        flash[:success] = "You are now registered and logged in"

      elsif user.role == "merchant"
        redirect_to '/merchant'
        flash[:success] = "You are now registered and logged in"

      else user.role == "admin"
        redirect_to '/admin'
        flash[:success] = "You are now registered and logged in"
      end

    else
      flash[:error] = "Sorry, your credentials are invalid"
      render :new
    end
  end
end
