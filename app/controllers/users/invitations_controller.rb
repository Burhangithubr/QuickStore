class Users::InvitationsController < Devise::InvitationsController
  protected

  def after_accept_path_for(resource)
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