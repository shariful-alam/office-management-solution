class AttendancesController < ApplicationController

  before_action :authenticate_user!
  before_action :block_foreign_hosts,only:[:create,:update]
  load_and_authorize_resource

  def index
    @attendances_available = @attendances.where(status: true).
      where(created_at: Date.current.beginning_of_day-6.hours..Date.current.end_of_day-6.hours).
      order('id ASC').paginate(:page => params[:page], :per_page => 20)

    @attendances_unavailable = @attendances.where(status: false).
      where(created_at: Date.current.beginning_of_day-6.hours..Date.current.end_of_day-6.hours).
      order('id ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance.info = current_user.id.to_s + '=>' + Date.today.to_date.to_s
    @attendance.user_id = current_user.id
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
    @attendance = Attendance.find(params[:id])
    @attendance.update(status: false)
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
