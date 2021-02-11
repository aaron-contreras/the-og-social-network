class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(user)
    new_user_session_path
  end
    
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_picture])
  end
end
