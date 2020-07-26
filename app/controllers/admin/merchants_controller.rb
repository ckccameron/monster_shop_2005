class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.status != "disabled"
      merchant.status = "disabled"
      merchant.save
      merchant.disable_items
      redirect_to "/admin/merchants"
      flash[:message] = "#{merchant.name} is now disabled"
    else merchant.status == "disabled"
      merchant.status = "enabled"
      merchant.save
      redirect_to "/admin/merchants"
      flash[:message] = "#{merchant.name} is now enabled"
    end
  end
end
