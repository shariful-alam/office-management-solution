class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :block_foreign_hosts
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image,:name, :phone, :role , :designation, :image_file_name, :image_content_type, :image_file_size,:image_updated_at,:remove_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image,:name, :phone, :role, :designation, :image_file_name, :image_content_type,:image_file_size,:image_updated_at,:remove_image])
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] =  "Access Denied!!"
    redirect_back(fallback_location: root_path)
  end



  def whitelisted?(ip)
    return true if ['::1'].include?(ip)
    false
  end

  def block_foreign_hosts
    return false if whitelisted?(request.remote_ip)
    redirect_to "https://www.google.com" unless request.remote_ip.start_with?("123.456.789")
  end





end
