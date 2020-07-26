class AddDefaultValueToOrderStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default :orders, :status, from: nil, to: "pending"
  end
end
