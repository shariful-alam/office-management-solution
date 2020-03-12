class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session, if: -> {request.format.json?}

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :name, :phone, :role,
                                                       :designation,:target_amount, :bonus_percentage])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :name, :phone, :role,
                                                        :designation,:target_amount, :bonus_percentage])
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access Denied!!"
    redirect_back(fallback_location: root_path)
  end

end
