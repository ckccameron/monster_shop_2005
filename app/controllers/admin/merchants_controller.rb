class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.status = "disabled"
    merchant.save
    merchant.disable_items
    redirect_to "/admin/merchants"
    flash[:message] = "#{merchant.name} is now disabled"
  end
end
