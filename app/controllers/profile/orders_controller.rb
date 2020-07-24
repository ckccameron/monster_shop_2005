class Profile::OrdersController < Profile::BaseController
  def index
   @user = User.find(session[:user_id])
  end

  def show

  end
end
