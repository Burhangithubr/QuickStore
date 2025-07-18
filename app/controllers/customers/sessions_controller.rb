class Customers::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    customers_dashboard_path
  # Redirect to customer dashboard
  end
end