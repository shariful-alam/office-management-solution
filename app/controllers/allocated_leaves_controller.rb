class AllocatedLeavesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @allocated_leaves = @allocated_leaves.includes(:user).where(year: params[:search].present? ? params[:search] : Date.today.year.to_s)
    @allocated_leaves = @allocated_leaves.paginate(:page => params[:page], :per_page => 20)
  end

  def new

  end

  def create
    @allocated_leafe = AllocatedLeafe.new(allocated_leafe_params)
    if @allocated_leafe.save
      redirect_to allocated_leaves_path, notice: 'Leave has been allocated successfully'
    else
      render :new
    end
  end

  def edit

  end

  def show
    @allocated_leaves = @allocated_leafe.allocated_leaves_count_for(@allocated_leafe.user)
  end

  def update
    if @allocated_leafe.update(allocated_leafe_params)
      redirect_to allocated_leaves_path, notice: 'Your information has been updated successfully'
    else
      render :edit
    end
  end

  def destroy
    if @allocated_leafe.destroy
      redirect_to allocated_leaves_path, alert: 'Information has been removed'
    else
      render :index
    end
  end

  def show_all
    @leaves = @allocated_leafe.user.leaves

    @leaves_pending = @leaves.pending.paginate(:page => params[:pending_leaves], :per_page => 20)
    @leaves_approved = @leaves.approved.paginate(:page => params[:approved_leaves], :per_page => 20)
    @leaves_rejected = @leaves.rejected.paginate(:page => params[:rejected_leaves], :per_page => 20)
  end

  private
  def allocated_leafe_params
    params.require(:allocated_leafe).permit(:user_id, :total_leave, :year)
  end

end
