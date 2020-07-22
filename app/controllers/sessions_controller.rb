class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}!"
    redirect_to '/profile'
  end
end
