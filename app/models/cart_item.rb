class CartItem < ApplicationRecord
    belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  validate :check_stock_limit

  def check_stock_limit
    if quantity.present? && product.present? && quantity > product.stock
      errors.add(:quantity, "exceeds available stock")
    end
  end
end
