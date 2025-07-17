class StockManager::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_stock_manager

  def index
    @store = current_user.store_users.find_by(role: "stock_manager")&.store
    @products = @store.products 
    @product = @store.products.build 
  end
    def destroy
      @product.destroy
      flash[:notice] = "Product deleted successfully."
      redirect_back fallback_location: stock_manager_products_path
    end

  private

  def ensure_stock_manager
    unless current_user.stock_manager?
      redirect_to root_path, alert: "Not authorized"
    end
  end
end
