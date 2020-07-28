class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    redirect_to "/admin/merchants/#{params[:merchant_id]}/items"
    flash[:message] = "#{item.name} has now been deleted"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    if item.save
      redirect_to "/admin/merchants/#{merchant.id}/items"
      flash[:message] = "#{item.name} has been created"
    end
  end

  private
  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
