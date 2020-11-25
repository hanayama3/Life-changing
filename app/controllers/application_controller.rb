class ApplicationController < ActionController::Base

add_flash_types :success, :warning, :danger

before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation, :image, :profile ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
