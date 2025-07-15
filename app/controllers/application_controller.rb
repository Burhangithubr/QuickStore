class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def after_sign_in_path_for(user)
    if user.owner?
      owner_dashboard_path
    elsif user.stock_manager?
      stock_manager_dashboard_path
    elsif user.dispatcher?
      dispatcher_dashboard_path
    else
      root_path
    end
  end
end
