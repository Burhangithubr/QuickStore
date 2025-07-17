class Customers::ProductsController < ApplicationController
  before_action :authenticate_customer! # <- use Devise's helper for Customer model

  def index
    @products = Product.where("stock > 0")
  end

  def show
    @product = Product.find(params[:id])
  end
end