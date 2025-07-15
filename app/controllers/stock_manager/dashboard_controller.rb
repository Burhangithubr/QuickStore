class StockManager::DashboardController < ApplicationController
 before_action :authenticate_user!
  before_action :ensure_stock_manager

  def index
    @stores = current_user.assigned_stores.includes(:products)
  end

  private

  def ensure_stock_manager
    redirect_to root_path, alert: "Not authorized" unless current_user.stock_manager?
  end
end
