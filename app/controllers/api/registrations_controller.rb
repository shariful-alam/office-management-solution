class Api::RegistrationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      render json: {message: "User exists"}, status: 422 and return
    end
    user = User.new(email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation],
                    name: params[:name],
                    phone: params[:phone],
                    role: params[:role],
                    target_amount: params[:target_amount],
                    bonus_percentage: params[:bonus_percentage])
    if user.save
      render json: {message: "Created Successfully"}, status: 200
    else
      render json: {message: "Unsuccessful"}, status: 422
    end
  end

end
