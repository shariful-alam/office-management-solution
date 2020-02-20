class AllocatedLeavesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource


  def index
    @allocated_leaves = @allocated_leaves.includes(:user).where(year: params[:search].present? ? params[:search] : Date.today.year.to_s)
    @allocated_leaves = @allocated_leaves.order(:id).paginate(:page => params[:page], :per_page => 20)
  end

  def new

  end

  def create
    @allocated_leafe = AllocatedLeafe.new(allocated_leafe_params)
    @allocated_leafe.used_leave = 0
    if @allocated_leafe.save
      redirect_to allocated_leaves_path, notice: 'Leave has been allocated successfully'
    else
      render :new
    end
  end

  def edit

  end

  def show
    @leaves = @allocated_leafe.user.leaves

    @allocated_personal = @leaves.with_leafe_type(Leafe::PL)
    @allocated_training = @leaves.with_leafe_type(Leafe::TL)
    @allocated_vacation = @leaves.with_leafe_type(Leafe::VL)
    @allocated_medical = @leaves.with_leafe_type(Leafe::ML)

    @allocated_personal = @allocated_personal.Approved.count
    @allocated_training = @allocated_training.Approved.count
    @allocated_vacation = @allocated_vacation.Approved.count
    @allocated_medical = @allocated_medical.Approved.count
  end

  def update
    if @allocated_leafe.update(allocated_leafe_params)
      redirect_to allocated_leaves_path, notice: 'Your information has been updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @allocated_leafe.destroy
    redirect_to allocated_leaves_path, alert: 'Information has been removed'
  end

  def show_all
    @leaves = params[:user_id].present? ? current_user.leaves : @allocated_leafe.user.leaves
    @leaves = @leaves.order(:id)

    @leaves_pending = @leaves.Pending.paginate(:page => params[:pending_leaves], :per_page => 20)
    @leaves_approved = @leaves.Approved.paginate(:page => params[:approved_leaves], :per_page => 20)
    @leaves_rejected = @leaves.Rejected.paginate(:page => params[:rejected_leaves], :per_page => 20)
  end

  private
  def allocated_leafe_params
    params.require(:allocated_leafe).permit(:user_id, :total_leave, :year)
  end


end
