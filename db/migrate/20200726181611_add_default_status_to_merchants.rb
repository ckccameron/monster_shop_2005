class AddDefaultStatusToMerchants < ActiveRecord::Migration[5.1]
  def change
    change_column_default :merchants, :status, from: nil, to: "enabled"
  end
end
