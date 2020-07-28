class Merchant::DashboardController < Merchant::BaseController
  def index
    merchant_id = MerchantUser.where(user_id: params[:id]).pluck(:merchant_id).pop
    if merchant_id.nil? == false
      @merchant = Merchant.find(merchant_id)
      @user = User.find(params[:id])
    else
      @user = User.find(params[:id])
    end
  end
end
