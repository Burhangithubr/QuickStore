class Customers::DashboardController < ApplicationController
  before_action :authenticate_customer!

  def index
    @products = Product.where("stock > 0")
    @cart = current_customer.cart || current_customer.create_cart
      @orders = current_customer.orders.order(created_at: :desc)
  end
end

