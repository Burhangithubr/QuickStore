class Customers::RegistrationsController < Devise::RegistrationsController
    protected

  def after_sign_up_path_for(resource)
    sign_out(resource)
    new_customer_session_path
  end
   def after_inactive_sign_up_path_for(resource)
    new_customer_session_path # for confirmable case
  end
 
end