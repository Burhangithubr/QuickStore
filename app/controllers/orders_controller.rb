class OrdersController < ApplicationController


def index
  if params[:store_id].present?
    @store = Store.find(params[:store_id])
    @orders = Order.joins(:order_items => :product)
                   .where(products: { store_id: @store.id })
                   .distinct
  else
    @orders = Order.all
  end
end


end
