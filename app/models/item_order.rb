class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def self.top_5_items
    ItemOrder.select("item_id, sum(quantity) as total_qty").group(:item_id).order("total_qty DESC").limit(5).map {|item| item.item}
  end

  def self.bottom_5_items
    ItemOrder.select("item_id, sum(quantity) as total_qty").group(:item_id).order("total_qty").limit(5).map {|item| item.item}
  end

  def self.total_qty_ordered(item)
    item.item_orders.sum(:quantity)
  end
end
