class LeavesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource


  def index
=begin
    if current_user.role != User::ADMIN
      if params[:date_from] and params[:date_to]
        #@search = Leafe.new(params[:search])
        @leaves_pending = Leafe.search_in_date_range(params[:date_from], params[:date_to]).where(status: 'Pending').order('id ASC')
        @leaves_approved = Leafe.search_in_date_range(params[:date_from], params[:date_to]).where(status: 'Approved').order('id ASC')
        @leaves_rejected = Leafe.search_in_date_range(params[:date_from], params[:date_to]).where(status: 'Rejected').order('id ASC')
      elsif params[:search]
        @leaves_pending = Leafe.search(params[:search]).where(status: 'Pending').order('id ASC')
        @leaves_approved = Leafe.search(params[:search]).where(status: 'Approved').order('id ASC')
        @leaves_rejected = Leafe.search(params[:search]).where(status: 'Rejected').order('id ASC')
      else
        @leaves_pending = Leafe.where(user_id: current_user.id, status: 'Pending').order('id ASC')
        @leaves_approved = Leafe.where(user_id: current_user.id, status: 'Approved').order('id ASC')
        @leaves_rejected = Leafe.where(user_id: current_user.id, status: 'Rejected').order('id ASC')
      end
    else
      if params[:date_from] and params[:date_to]
        #@search = Leafe.new(params[:search])
        @leaves_pending = Leafe.search_in_date_range(params[:date_from], params[:date_to]).where(status: 'Pending').order('id ASC')
        @leaves_approved = Leafe.search_in_date_range(params[:date_from], params[:date_to]).where(status: 'Approved').order('id ASC')
        @leaves_rejected = Leafe.search_in_date_range(params[:date_from], params[:date_to]).where(status: 'Rejected').order('id ASC')
      elsif params[:search]
        @leaves_pending = Leafe.search(params[:search]).where(status: 'Pending').order('id ASC')
        @leaves_approved = Leafe.search(params[:search]).where(status: 'Approved').order('id ASC')
        @leaves_rejected = Leafe.search(params[:search]).where(status: 'Rejected').order('id ASC')
      else
        @leaves_pending = Leafe.where(status: 'Pending').order('id ASC')
        @leaves_approved = Leafe.where(status: 'Approved').order('id ASC')
        @leaves_rejected = Leafe.where(status: 'Rejected').order('id ASC')
      end
    end
=end
    @leaves_pending = Leafe.search(params[:from], params[:to], params[:search], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]= Leafe::PENDING, params[:page])
    @leaves_approved = Leafe.search(params[:from], params[:to], params[:search], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]=Leafe::APPROVED, params[:page])
    @leaves_rejected = Leafe.search(params[:from], params[:to], params[:search], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]=Leafe::REJECTED, params[:page])
    @info = current_user.id.to_s + '=>' + Date.today.to_date.to_s
    @attendance = Attendance.where(info: @info).last
  end

  def new
    @leave = Leafe.new
    #@user = User.all
  end

  def create
    @leave = Leafe.new(leafe_params)
    @leave.user_id = current_user.id
    if @leave.save
      redirect_to show_all_allocated_leafe_path(@leave.user_id), notice: "Your Application Has Bees Submitted for Approval"
    else
      render 'new'
    end
  end

  def edit
    @leave = Leafe.find(params[:id])
  end

  def show
    @leave = Leafe.find(params[:id])
    #@user = User.find(@leave.user_id)
  end

  def update
    #raise params.inspect
    @leave = Leafe.find(params[:id])
    if @leave.update(leafe_params)
      redirect_to show_all_allocated_leafe_path(@leave.user_id), notice: "Your Information Has Been Updated"
    else
      render 'edit'
    end
  end

  def destroy
    @leave = Leafe.find(params[:id])
    @leave.destroy
    flash[:notice] = "Information Has Destroyed"
    redirect_back(fallback_location: show_all_allocated_leafe_path(@leave.user_id))
  end

  def approve
    @leave = Leafe.find(params[:id])
    if @leave.status == Leafe::APPROVED
      @leave.status = Leafe::PENDING
      @allocated_leave = AllocatedLeafe.where(user_id: @leave.user_id).last
      @allocated_leave.used_leave -= 1
      @allocated_leave.save
      flash[:notice] = "The Leafe information has been changed successfully"
    else
      @leave.status = Leafe::APPROVED
      @leave.approve_time = @leave.updated_at
      @allocated_leave = AllocatedLeafe.find_by(user_id: @leave.user_id)
      @allocated_leave.used_leave += 1
      @allocated_leave.save
      LeafeMailer.approved(@leave).deliver_now
      #raise @allocated_leave.inspect
      flash[:notice] = "Leafe has been approved successfully"
    end
    @leave.save
    redirect_back(fallback_location: show_all_allocated_leafe_path(@leave.user_id))
  end

  def reject
    @leave = Leafe.find(params[:id])
    @leave.status = Leafe::REJECTED
    flash[:notice] = "The Leafe information has been changed successfully"
    @leave.save
    LeafeMailer.rejected(@leave).deliver_now
    redirect_back(fallback_location: show_all_allocated_leafe_path(@leave.user_id))
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status)
  end


end
