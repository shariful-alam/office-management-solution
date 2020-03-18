class Api::AttendancesController < Api::ApiController

  before_action :authenticate_user_from_token
  before_action :block_foreign_hosts, only: [:create, :update]
  load_and_authorize_resource

  def index
    @attendances = @attendances.includes(:user).where(date: Date.today.to_date)
    @attendances_available = @attendances.where(status: true)
    @attendances_unavailable = @attendances.where(status: false)
  end

  def create
    @attendance = current_user.attendances.new({date: Date.today.to_date, status: true})
    if @attendance.save
      render json: { message: "You have checked In Successfully!!" }, status: 201
    else
      render json: { message: "You have already checked In Today!!" }, status: 422
    end
  end

  def check_out
    @attendance = current_user.attendances
    @attendance = @attendance.where(date: Date.today.to_date).last

    if @attendance.status? && @attendance.update({ status: false })
      render json: { message: "You have checked Out Successfully!!" }, status: 202
    else
      render json: { message: "You are not checked in" }, status: 422
    end
  end

  def whitelisted?(ip)
    ip_address = Rails.env.development? ? Attendance::LOCALHOST_IP_ADDRESS : Attendance::OFFICE_IP_ADDRESSES
    ip_address.include?(ip) ? true : false
  end

  def block_foreign_hosts
    return false if whitelisted?(request.remote_ip)
    render json: { message: "You can not access this from outside !!" }, status: 401
  end


end
