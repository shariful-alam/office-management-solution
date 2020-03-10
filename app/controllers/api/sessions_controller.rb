class Api::SessionsController < BaseController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])
    unless user.present?
      render json: {message: "User not found"}, status: 422 and return
    end

    if user.valid_password?(params[:password])
      token = user.token
      unless token.present?
        loop do
          token = Devise.friendly_token
          unless User.exists?(token: token)
            user.update({token: token})
            break token
          end
        end
      end

      render json: {token: token}, status: 200
    else
      render json: {message: "Email or password is invalid"}, status: 422
    end
  end

end
