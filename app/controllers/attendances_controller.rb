class AttendancesController < ApplicationController

  before_action :authenticate_user!
  before_action :block_foreign_hosts, only: [:create, :update]
  load_and_authorize_resource

  def index
    @attendances_available = @attendances.includes(:user).where(status: true, date: Date.today.to_date).
      order(:id).paginate(:page => params[:available], :per_page => 20)

    @attendances_unavailable = @attendances.includes(:user).where(status: false, date: Date.today.to_date).
      order(:id).paginate(:page => params[:unavailable], :per_page => 20)
  end

  def create
    @attendance.user = current_user
    @attendance.date = Date.today.to_date
    @attendance.status = true
    if @attendance.save
      flash[:notice] = "You have Checked In Successfully!!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "You have Already Checked In Today!!"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @attendance.update_attribute(:status, false)
    flash[:notice] = "You have checked Out Successfully!!"
    redirect_back(fallback_location: root_path)
  end

  def whitelisted?(ip)
    #return true if ['27.147.206.53'].include?(ip)
    return true if ['::1'].include?(ip)
    false
  end

  def block_foreign_hosts
    return false if whitelisted?(request.remote_ip)
    flash[:alert] = "You can not access this from outside !!"
    redirect_back(fallback_location: root_path)
  end


end
