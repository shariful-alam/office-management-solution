class AllocatedLeavesController < ApplicationController


  def index
    @allocated_leaves = AllocatedLeave.order('id ASC').paginate(:page => params[:page], :per_page => 3)
  end

  def new
    @allocated_leave = AllocatedLeave.new
  end

  def create
    @allocated_leave = AllocatedLeave.new(allocated_leave_params)
    @allocated_leave.used_leave = 0
    @allocated_leave.save
    flash[:notice] = "Leave Information Has Been Created"
    redirect_to allocated_leaves_path
  end

  def edit
    @allocated_leave = AllocatedLeave.find(params[:id])
  end

  def show
    @allocated_leave = AllocatedLeave.find(params[:id])
  end

  def update
    @allocated_leave = AllocatedLeave.find(params[:id])
    @allocated_leave.update(allocated_leave_params)
    flash[:notice] = "Your Information Has Been Updated"
    redirect_to allocated_leaves_path
  end

  def destroy
    @allocated_leave = AllocatedLeave.find(params[:id])
    @allocated_leave.destroy
    flash[:notice] = "Information Has Destroyed"
    redirect_to allocated_leaves_path
  end

  def show_all
    @allocated_leave = AllocatedLeave.find(params[:id])
    @leaves = Leave.where(user_id: @allocated_leave.user_id).order('id ASC').paginate(:page => params[:page], :per_page => 3)
    #raise @leaves.inspect
  end

  private
  def allocated_leave_params
    params.require(:allocated_leave).permit(:user_id, :total_leave )
  end



end
