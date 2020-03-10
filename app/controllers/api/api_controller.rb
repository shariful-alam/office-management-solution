class Api::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def authenticate_user_from_token
    user = User.find_by(token: params[:token])
    unless user.present?
      render json: {message: "invalid token"}, status: 422 and return
    end
    @current_user = user
  end

  def current_user
    @current_user
  end
end
