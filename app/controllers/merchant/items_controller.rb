class Merchant::ItemsController < Merchant::BaseController
  def index
    merchant_user = User.find(session[:user_id])
    merchant = merchant_user.merchants.first
    @items = merchant.items
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to "/merchant/items"
    flash[:message] = "#{item.name} has now been deleted"
  end
end
