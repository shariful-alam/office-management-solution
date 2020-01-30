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

    #raise @attendance.inspect
    if @attendance.save
      redirect_to allocated_leaves_path, notice: "Your Attendance has been recorded"
    else
      redirect_to allocated_leaves_path, alert: "You have already checked in"
    end
  end

  def update
    #raise @attendance.inspect
    #@info = .to_s + '=>' + Date.today.to_date.to_s
    @attendance = Attendance.find(params[:id]).update(status: false)
    #raise @attendance.inspect
    #@attendance.

    # @attendance.save
    redirect_to allocated_leaves_path, notice: "You have checked out"
  end




end
