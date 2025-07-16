class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :authorize_stock_manager, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = @store.products
    @product = @store.products.build
  end

  def new
    @product = @store.products.build
  end
  def create
  @product = @store.products.build(product_params)
  if @product.save
    redirect_to stock_manager_dashboard_path, notice: "Product created successfully."
  else
    render :new
  end
end


  def edit
  end

  def update
  if @product.update(product_params)
    redirect_to stock_manager_dashboard_path, notice: "Product updated successfully."
  else
    @products = @store.products  
    render :index  
  end
end

  def destroy
    @product.destroy
    redirect_to store_products_path(@store), notice: "Product deleted successfully."
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_product
    @product = @store.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :image, :max_purchase_limit)
  end

  def authorize_stock_manager
    unless current_user.stock_manager?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
