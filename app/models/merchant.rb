class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :orders, through: :item_orders
  has_many :merchant_users
  has_many :users, through: :merchant_users

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def disable_all_items
    items.update(:active? => false)
  end

  def enable_all_items
    items.update(:active? => true)
  end

  def pending_orders
    orders.where(status: 1)
  end

end
