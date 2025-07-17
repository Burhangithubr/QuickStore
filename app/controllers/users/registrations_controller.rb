class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    super do |resource|
      # Set default role to "owner" if not set manually
      resource.role ||= "owner"
      resource.save
    end
  end

  protected

  def after_sign_up_path_for(resource)
    sign_out(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # or add more if needed
  end
end
