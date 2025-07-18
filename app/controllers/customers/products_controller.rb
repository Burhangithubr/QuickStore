# app/controllers/customers/products_controller.rb
class Customers::ProductsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @store = Store.find(params[:store_id])
    @products = @store.products.where("stock > 0")
  end

  def show
    @product = Product.find(params[:id])
  end
end
