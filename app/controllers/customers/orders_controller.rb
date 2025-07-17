class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart

 def index
  @orders = current_customer.orders.includes(order_items: :product).order(created_at: :desc)
end
def show
  @order = current_customer.orders.find_by(id: params[:id])
  unless @order
    redirect_to customers_dashboard_path, alert: "Order not found."
  end
end

  def new
    @address = current_customer.default_address || current_customer.addresses.build
  end
  
  def create
    address_text = if params[:use_default] == "1"
                     current_customer.default_address&.full_address
                   else
                     params[:shipping_address]
                   end

    if address_text.blank?
      flash.now[:alert] = "Shipping address is required."
      @address = current_customer.default_address || current_customer.addresses.build
      return render :new
    end

    ActiveRecord::Base.transaction do
      # Save new address if entered manually
      if params[:use_default] != "1"
        current_customer.addresses.create!(full_address: address_text, default: true)
      end

      order = current_customer.orders.create!(
        store: @cart.cart_items.first.product.store,
        total_amount: @cart.total_price,
        status: "pending",
        shipping_address: address_text
      )

      @cart.cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          unit_price: item.product.price
        )
      end

      @cart.cart_items.destroy_all
      redirect_to customers_order_path(order), notice: "Order placed successfully!"
    end
  rescue => e
    redirect_to new_customers_order_path, alert: "Order failed: #{e.message}"
  end
  private

  def set_cart
    @cart = current_customer.cart
  end
end
