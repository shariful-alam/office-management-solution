class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image,:name, :phone, :role , :image_file_name, :image_content_type, :image_file_size,:image_updated_at])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image,:name, :phone, :role, :image_file_name, :image_content_type,:image_file_size,:image_updated_at])
  end

end
