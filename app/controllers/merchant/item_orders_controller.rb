class Merchant::ItemOrdersController < Merchant::BaseController
  def update
    item_order = ItemOrder.find(params[:item_order_id])
    item_order.update(fulfill_status: "fulfilled")
    item_order.item.update(inventory: item_order.item.inventory - item_order.quantity)
    flash[:success] = "Item #{item_order.item.id} (#{item_order.item.name}) is fulfilled for Order ID #{item_order.order.id}"
    redirect_to "/merchant/orders/#{item_order.order.id}"
  end
end
