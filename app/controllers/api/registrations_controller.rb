class Api::RegistrationsController < Api::ApiController

  before_action :authenticate_user_from_token
  #load_and_authorize_resource

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      render json: {message: "User exists"}, status: 422 and return
    end
    user = User.create(registration_params)
    if user.save
      render json: {message: "Created Successfully"}, status: 200
    else
      render json: {message: "Unsuccessful"}, status: 422
    end
  end

  private
  def registration_params
    params.require(:registration).permit(:name, :email, :phone, :designation, :role, :password,
                                 :password_confirmation, :target_amount,
                                 :bonus_percentage)
  end

end
