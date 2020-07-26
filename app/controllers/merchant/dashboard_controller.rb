class Merchant::DashboardController < Merchant::BaseController
  def index
    merchant_id = MerchantUser.where(user_id: params[:user_id]).pluck(:merchant_id).pop
    @merchant = Merchant.find(merchant_id)
  end
end
