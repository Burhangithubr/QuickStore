class Product < ApplicationRecord
  belongs_to :store
  has_many :cart_items

  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :max_purchase_limit, numericality: { greater_than: 0, allow_nil: true }

def in_stock?(quantity)
    stock >= quantity
  end

end
