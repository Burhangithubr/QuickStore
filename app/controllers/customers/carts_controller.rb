class Customers::CartsController < ApplicationController
  before_action :authenticate_customer!

  def show
    @cart = current_customer.cart || current_customer.create_cart
  end
end