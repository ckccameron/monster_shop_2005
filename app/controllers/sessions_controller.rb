class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id

      if user.role == "default"
        redirect_to '/profile'
        flash[:success] = "Logged in as #{user.name}"

      elsif user.role == "merchant"
        redirect_to '/merchant'
        flash[:success] = "Logged in as #{user.name}"

      else user.role == "admin"
        redirect_to '/admin'
        flash[:success] = "Logged in as #{user.name}"
      end

    else
      flash[:error] = "Sorry, your credentials are invalid"
      render :new
    end
  end
end
