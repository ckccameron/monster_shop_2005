class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    binding.pry
    redirect_to "/admin/merchants"
  end
end
