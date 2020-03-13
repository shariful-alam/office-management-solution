class Api::SessionsController < Api::ApiController

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

  def sign_out
    if params[:token].present?
      user = User.find_by(token: params[:token])
      unless user.present?
        render json: {message: "Invalid credentials"}, status: 422
      else
        user.update({token: nil})
        render json: {message: "#{params[:token]} has been destroyed successfully"}, status: 201
      end
    else
      render json: {message: "Invalid credentials"}, status: 422
    end
  end
end
