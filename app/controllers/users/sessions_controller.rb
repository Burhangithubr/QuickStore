# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    case resource.role
    when "stock_manager"
      stock_manager_dashboard_path
    when "dispatcher"
      dispatcher_dashboard_path
    else
      owner_dashboard_path
    end
  end
end
