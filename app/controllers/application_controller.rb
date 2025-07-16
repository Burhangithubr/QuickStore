class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def after_sign_in_path_for(resource)
  if resource.is_a?(Customer)
    customers_dashboard_path
  elsif resource.is_a?(User)
    case resource.role
    when "owner"
      owner_dashboard_path
    when "stock_manager"
      stock_manager_dashboard_path
    when "dispatcher"
      dispatcher_dashboard_path
    else
      root_path
    end
  else
    root_path
  end
end
end
