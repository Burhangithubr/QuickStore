class Customers::CartsController < ApplicationController
  before_action :authenticate_customer!

def show
  @cart = current_customer.cart || current_customer.create_cart

  @store = @cart.cart_items.first&.product&.store

  if @store.nil? && params[:store_id]
    @store = Store.find(params[:store_id])
  end

  @payment_method = @store&.payment_methods&.last

end




end