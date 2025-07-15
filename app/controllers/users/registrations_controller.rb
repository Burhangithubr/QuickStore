class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Override the default Devise behavior
  def after_sign_up_path_for(resource)
    # Sign the user out after sign-up
    sign_out(resource)
    new_user_session_path  # Redirect to login page
  end
end
