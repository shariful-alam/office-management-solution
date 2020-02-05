class AttendancesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @attendances_available = Attendance.where(status: true).order('id ASC').paginate(:page => params[:page], :per_page => 3)
    @attendances_unavailable = Attendance.where(status: false).order('id ASC').paginate(:page => params[:page], :per_page => 3)
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
    @attendance = Attendance.new
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




end
