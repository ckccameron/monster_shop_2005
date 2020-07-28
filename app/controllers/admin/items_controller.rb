class Admin::ItemsController < Admin::BaseController
  def index
    merchant = Merchant.find(params[:id])
    @items = merchant.items
  end

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    redirect_to "/admin/merchants/#{params[:merchant_id]}/items"
    flash[:message] = "#{item.name} has now been deleted"

  end
end
