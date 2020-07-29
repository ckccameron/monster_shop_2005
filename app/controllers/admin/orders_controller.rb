class Admin::OrdersController < Admin::BaseController
  def update
    # require "pry"; binding.pry
    order = Order.find(params[:order_id])
    order.update(status: 2)
    order.save
    redirect_to "/admin/"
  end
end
