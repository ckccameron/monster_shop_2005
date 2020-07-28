class Merchant::DashboardController < Merchant::BaseController
  def index
    @user = User.find(params[:id])
    @merchant = @user.merchants.first
  end
end
