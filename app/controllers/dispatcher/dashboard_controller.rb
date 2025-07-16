class Dispatcher::DashboardController < ApplicationController
 before_action :authenticate_user!
  before_action :ensure_dispatcher

    def index
    @store = current_user.store_users.find_by(role: "dispatcher")&.store
  end

  private

  def ensure_dispatcher
    redirect_to root_path, alert: "Not authorized" unless current_user.dispatcher?
  end
end
