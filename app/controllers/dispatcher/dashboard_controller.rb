class Dispatcher::DashboardController < ApplicationController
 before_action :authenticate_user!
  before_action :ensure_dispatcher

  def index
    @stores = current_user.assigned_stores.includes(:orders)
  end

  private

  def ensure_dispatcher
    redirect_to root_path, alert: "Not authorized" unless current_user.dispatcher?
  end
end
