class AllocatedLeavesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource


  def index
    if params[:search]
      @allocated_leaves = @allocated_leaves.where(year: params[:search])
    else
      @allocated_leaves = @allocated_leaves.where(year: Date.today.year.to_s)
    end
    @allocated_leaves = @allocated_leaves.order('id ASC').paginate(:page => params[:page], :per_page => 20)
  end


  def new

  end

  def create
    @allocated_leafe = AllocatedLeafe.new(allocated_leafe_params)
    @allocated_leafe.used_leave = 0
    if @allocated_leafe.save
      redirect_to allocated_leaves_path, notice: "Leave Information has been Created Successfully!!"
    else
      render 'new'
    end
  end

  def edit

  end

  def show
    @leaves = Leafe.where(user_id: @allocated_leafe.user_id)

    @allocated_personal = @leaves.with_leafe_type(Leafe::PL)
    @allocated_training = @leaves.with_leafe_type(Leafe::TL)
    @allocated_vacation = @leaves.with_leafe_type(Leafe::VL)
    @allocated_medical = @leaves.with_leafe_type(Leafe::ML)

    @allocated_personal = @allocated_personal.with_status(Leafe::APPROVED).count
    @allocated_training = @allocated_training.with_status(Leafe::APPROVED).count
    @allocated_vacation = @allocated_vacation.with_status(Leafe::APPROVED).count
    @allocated_medical = @allocated_medical.with_status(Leafe::APPROVED).count
  end

  def update
    if @allocated_leafe.update(allocated_leafe_params)
      redirect_to allocated_leaves_path, notice: "Your Information has been Updated Successfully!!"
    else
      render :edit
    end
  end

  def destroy
    @allocated_leafe.destroy
    redirect_to allocated_leaves_path, alert: "Information has been Removed!!"
  end

  def show_all
    @leaves = params[:user_id].present? ? current_user.leaves : @allocated_leafe.user.leaves
    @leaves = @leaves.order('id ASC')

    @leaves_pending = @leaves.with_status(Leafe::PENDING).paginate(:page => params[:page], :per_page => 20)
    @leaves_approved = @leaves.with_status(Leafe::APPROVED).paginate(:page => params[:page], :per_page => 20)
    @leaves_rejected = @leaves.with_status(Leafe::REJECTED).paginate(:page => params[:page], :per_page => 20)
  end

  private
  def allocated_leafe_params
    params.require(:allocated_leafe).permit(:user_id, :total_leave, :year)
  end


end
