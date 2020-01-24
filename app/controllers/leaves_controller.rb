class LeavesController < ApplicationController
  before_action :authenticate_user!
  before_action :check, only: [:edit]


  def check
    if current_user.role!=User::ADMIN
      @leave = Leave.find(params[:id])
      if @leave.user_id != current_user.id
        flash[:notice] = "Access Denied"
        redirect_to leaves_path
      end
    end
  end

  def index
    if params[:search]
      @leaves = Leave.search(params[:search]).order('id ASC').paginate(:page => params[:page], :per_page => 3)
    else
      @leaves = Leave.order('id ASC').paginate(:page => params[:page], :per_page => 3)
    end
  end

  def new
    @leave = Leave.new
    #@user = User.all
  end

  def create
    @leave = Leave.new(leave_params)
    @leave.user_id = current_user.id
    @leave.save
    flash[:notice] = "Your Application Has Bees Submitted for Approval"
    redirect_to leaves_path
  end

  def edit
    @leave = Leave.find(params[:id])
  end

  def show
    @leave = Leave.find(params[:id])
    #@user = User.find(@leave.user_id)
  end

  def update
    #raise params.inspect
    @leave = Leave.find(params[:id])
    @leave.update(leave_params)
    flash[:notice] = "Your Information Has Been Updated"
    redirect_to leaves_path
  end

  def destroy
    @leave = Leave.find(params[:id])
    @leave.destroy
    flash[:notice] = "Information Has Destroyed"
    redirect_to leaves_path
  end

  def approve
    @leave = Leave.find(params[:id])
    if @leave.status == Leave::APPROVED
      @leave.status = Leave::PENDING
      flash[:notice] = "The Leave information has been changed successfully"
    else
      @leave.status = Leave::APPROVED
      flash[:notice] = "Leave has been approved successfully"
    end
    #raise @leave.inspect
    @leave.save
    redirect_to leaves_path
  end


  private
  def leave_params
    params.require(:leave).permit(:start_date, :end_date, :reason, :leave_type, :status )
  end



end
