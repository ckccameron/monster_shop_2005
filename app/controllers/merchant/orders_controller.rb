class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:order_id])
    user = User.find(session[:user_id])
    @merchant = user.merchants.first
  end
end
