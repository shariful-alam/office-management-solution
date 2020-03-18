class Api::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def authenticate_user_from_token
    if params[:token].present?
      user = User.find_by(token: params[:token])
      unless user.present?
        render json: { error: "Invalid credentials" }, status: 401 and return
      end
    else
      render json: { error: "User have to sign in" }, status: 401 and return
    end
    @current_user = user
  end

  def current_user
    @current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: "Access Denied" }, status: 401
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { error: "Record not found!!" }, status: 422
  end

end
