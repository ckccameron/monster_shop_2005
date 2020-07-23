class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user.role == "default"
      redirect_to_path
    elsif @current_user.role == "merchant"
      redirect_to_path
    else @current_user.role == "admin"
      redirect_to_path
    end
  end

  def logged_in?
    #require "pry"; binding.pry
    session[:user_id].present?
    
  def current_admin?
    current_user && current_user.admin?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end
end
