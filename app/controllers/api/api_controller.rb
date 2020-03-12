class Api::ApiController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    render json: {message: "Record not found!!"}, status: 422
  end

  skip_before_action :verify_authenticity_token

  def authenticate_user_from_token
    if params[:token].present?
      user = User.find_by(token: params[:token])
      unless user.present?
        render json: {message: "Invalid credentials"}, status: 422 and return
      end
    else
      render json: {message: "User have to sign in"}, status: 422 and return
    end
    @current_user = user
  end

  def current_user
    @current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: {message: "Access Denied"}, status: 401
  end

end
