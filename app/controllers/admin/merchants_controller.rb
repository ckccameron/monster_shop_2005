class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.status != "disabled"
      merchant.status = "disabled"
      merchant.save
      merchant.disable_all_items
      redirect_to "/admin/merchants"
      flash[:message] = "#{merchant.name} is now disabled"
    else merchant.status == "disabled"
      merchant.status = "enabled"
      merchant.save
      merchant.enable_all_items
      redirect_to "/admin/merchants"
      flash[:message] = "#{merchant.name} is now enabled"
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end
