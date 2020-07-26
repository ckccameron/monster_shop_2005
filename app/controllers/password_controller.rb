class PasswordController < ApplicationController
  def edit
  end

  def update
    return password_blank_failure if params[:password] == ""
    if params[:password] == params[:confirm_password]
      password_update_success
    elsif
     password_not_matching_failure
    end
  end

  private
  def password_params
    params.permit(:password, :confirm_password)
  end

  def password_update_success
    current_user.update(password: params[:password])
    flash[:notice]= "Password updated successfully"
    return redirect_to "/profile"
  end

  def password_not_matching_failure
    flash[:error] = "Password update failed - password and password confirmation must be matching"
    redirect_to "/profile/password/edit"
  end

  def password_blank_failure
    flash[:error] = "Password update failed - password and/or password confirmation cannot be blank"
    redirect_to "/profile/password/edit"
  end
end
