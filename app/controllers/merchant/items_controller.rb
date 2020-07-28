class Merchant::ItemsController < Merchant::BaseController
  def index
    merchant_id = MerchantUser.where(user_id: session[:user_id]).pluck(:merchant_id).pop
    @merchant = Merchant.find(merchant_id)
  end

  def update
    item = Item.find(params[:item_id])
    if params[:type] == "deact"
      item.update(active?: false)
    else
      item.update(active?: true)
    end
    redirect_to '/merchant/items'
  end
end
