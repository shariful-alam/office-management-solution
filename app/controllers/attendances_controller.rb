class AttendancesController < ApplicationController

  before_action :authenticate_user!
  before_action :block_foreign_hosts, only: [:create, :update]
  load_and_authorize_resource

  def index
    @attendances = @attendances.includes(:user).where(date: Date.today.to_date)
    @attendances_available = @attendances.where(status: true).paginate(:page => params[:available], :per_page => Attendance::PER_PAGE)
    @attendances_unavailable = @attendances.where(status: false).paginate(:page => params[:unavailable], :per_page => Attendance::PER_PAGE)
  end

  def create
    @attendance = current_user.attendances.new({date: Date.today.to_date ,status: true})
    if @attendance.save
      flash[:notice] = "You have Checked In Successfully!!"
    else
      flash[:alert] = "You have Already Checked In Today!!"
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @attendance.update({status: false})
    redirect_back(fallback_location: root_path , notice: "You have checked Out Successfully!!")
  end

  def whitelisted?(ip)
    ip_address = Rails.env.development? ? Attendance::LOCALHOST_IP_ADDRESS : Attendance::OFFICE_IP_ADDRESSES
    ip_address.include?(ip) ? true : false
  end

  def block_foreign_hosts
    return false if whitelisted?(request.remote_ip)
    redirect_back(fallback_location: root_path , alert: "You can not access this from outside !!")
  end


end
