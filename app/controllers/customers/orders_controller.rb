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
  if @cart.cart_items.empty?
    redirect_to customers_cart_path, alert: "Cart is empty."
    return
  end

  # Get PaymentMethod by ID (not name)
  payment_method = PaymentMethod.find_by(id: params[:payment_method_id])
  unless payment_method
    redirect_to customers_cart_path, alert: "Invalid payment method."
    return
  end

  # Determine shipping address
  shipping_address = if params[:use_default] == "1"
                       current_customer.default_address&.full_address
                     else
                       address = current_customer.addresses.create(full_address: params[:shipping_address])
                       address.full_address
                     end

  if shipping_address.blank?
    redirect_to customers_cart_path, alert: "Shipping address is required."
    return
  end
 order_status = payment_method.payment_type.downcase == "mock" ? "confirmed" : "pending"
 Rails.logger.debug("Setting order status to: #{order_status}")
  @order = Order.new(
    customer: current_customer,
    store: @cart.cart_items.first.product.store,
    total_amount: @cart.total_price,
    shipping_address: shipping_address,
    payment_method: payment_method,
     status: order_status 
  )

  @cart.cart_items.each do |item|
    @order.order_items.build(
      product: item.product,
      quantity: item.quantity,
      unit_price: item.product.price
    )
  end

  if @order.save
     OrderMailer.customer_order_confirmation(@order).deliver_later
    OrderMailer.store_owner_notification(@order).deliver_later
    
    @cart.cart_items.destroy_all
    redirect_to customers_dashboard_path, notice: "Thank you! Order placed successfully."
  else
    flash[:alert] = "Order could not be placed. Please try again."
    redirect_to customers_cart_path
  end
end




  private

  def set_cart
    @cart = current_customer.cart
  end
 def order_params
  params.permit(:shipping_address, :use_default, :payment_method_id)
end


end
