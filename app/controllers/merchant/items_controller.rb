class Merchant::ItemsController < Merchant::BaseController
  def index
    user = User.find(session[:user_id])
    @items = user.merchants[0].items
  end

  def new
    
  end
end
