class Product < ApplicationRecord
  belongs_to :store
  has_many :cart_items

  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :max_purchase_limit, numericality: { greater_than: 0, allow_nil: true }

def in_stock?(quantity)
    stock_quantity >= quantity
  end
  
end
