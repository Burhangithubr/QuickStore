class Owner::DashboardController < ApplicationController
 before_action :authenticate_user!
  before_action :ensure_owner

  def index
    @stores = current_user.stores.includes(:products, :orders, :staff)
  end

  private

  def ensure_owner
    redirect_to root_path, alert: "Not authorized" unless current_user.owner?
  end
end
