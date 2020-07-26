class UsersController < ApplicationController
  def new
  end

  def create
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
    @user = User.find(session[:user_id])
    render file: "/public/404" if !current_user
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(session[:user_id])
    if user.update(user_params)
      user.save
      flash[:notice] = "Profile updated successfully"
      redirect_to "/profile"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to "/profile/edit"
    end
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
