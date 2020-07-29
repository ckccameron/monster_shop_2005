class Order < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: %w(packaged pending shipped cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    if status != "cancelled"
      items.count
    else
      0
    end
  end

  def status_packaged
    if item_orders.where(status: "UNFULFILLED")
      self.update(status: "packaged")
    end
  end

  def self.packaged_orders
    Order.where(status: "packaged")
  end
end
