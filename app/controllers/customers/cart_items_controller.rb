class Customers::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    cart_item = @cart.cart_items.find_or_initialize_by(product_id: product.id)

    new_quantity = cart_item.quantity.to_i + quantity
    cart_item.quantity = [new_quantity, product.stock].min

    if cart_item.save
      redirect_to customers_cart_path, notice: "Added to cart."
    else
      redirect_to customers_dashboard_path, alert: "Could not add to cart."
    end
  end
  def destroy
    @cart.cart_items.find(params[:id]).destroy
    redirect_to customers_cart_path, notice: "Removed from cart."
  end

  private

  def set_cart
    @cart = current_customer.cart || current_customer.create_cart
  end
end
