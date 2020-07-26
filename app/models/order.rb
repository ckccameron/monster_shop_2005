class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

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

  def total_quantity
    item_orders.inject(0) { |sum, item_order| sum + item_order.quantity }
  end

  def total_value
    item_orders.inject(0) { |sum, item_order| sum + (item_order.quantity * item_order.price) }
  end
end
