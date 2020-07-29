class Merchant::ItemsController < Merchant::BaseController
  def index
    merchant_user = User.find(session[:user_id])
    @merchant = merchant_user.merchants.first
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to "/merchant/items"
    flash[:message] = "#{item.name} has now been deleted"
  end

  def new
  end

  def create
    merchant_user = User.find(session[:user_id])
    merchant = merchant_user.merchants.first
    @item = merchant.items.create(item_params)
    if @item.save
      redirect_to "/merchant/items"
      flash[:message] = "#{@item.name} has been created"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
   @item = Item.find(params[:item_id])
   @item.update(item_params)
   # if params[:type] == "deact"
   #  @item.update(active?: false)
   # else
   #  @item.update(active?: true)
   # end
   if @item.save
     redirect_to '/merchant/items'
     flash[:message] = "Item Updated"
   else
     redirect_to "/merchant/items/#{@item.id}/edit"
     flash[:error] = @item.errors.full_messages.to_sentence
   end
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  private
  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
