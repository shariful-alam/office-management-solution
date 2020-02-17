class LeavesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource


  def index

    @leaves=@leaves.joins(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @leaves = @leaves.where("users.name ilike :search OR leave_type ilike :search", {search: search})
    end

    @leaves = @leaves.where(':from <= end_date ', {from: params[:from]}) if params[:from].present?
    @leaves = @leaves.where(':to >= start_date ', {to: params[:to]}) if params[:to].present?
    @leaves = @leaves.order('id ASC')

    @leaves_pending = @leaves.with_status(Leafe::PENDING).paginate(:page => params[:page], :per_page => 20)
    @leaves_approved = @leaves.with_status(Leafe::APPROVED).paginate(:page => params[:page], :per_page => 20)
    @leaves_rejected = @leaves.with_status(Leafe::REJECTED).paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @leafe = current_user.leaves.new
  end

  def create
    @leafe = current_user.leaves.new(leafe_params)
    @count = (@leafe.start_date..@leafe.end_date).select {|a| a.wday < 6 && a.wday > 0}.count
    if @count > 0
      if @leafe.save
        redirect_to leaves_path, notice: "Your Application Has Been Submitted for Approval"
      else
        render :new
      end
    else
      flash[:warning] = "Please Select a Valid Date Range!!"
      render :new
    end

  end

  def edit

  end

  def show

  end

  def update
    if @leafe.update(leafe_params)
      redirect_to show_all_allocated_leafe_path(@leafe.user_id), notice: "Your Information Has Been Updated"
    else
      render 'edit'
    end
  end

  def destroy
    @leafe = Leafe.find(params[:id])
    @leafe.destroy
    flash[:notice] = "Information Has Destroyed"
    redirect_back(fallback_location: show_all_allocated_leafe_path(@leafe.user_id))
  end

  def approve
    @leafe = Leafe.find(params[:id])
    @count = (@leafe.start_date..@leafe.end_date).select {|a| a.wday < 6 && a.wday > 0}.count
    if @leafe.status == Leafe::APPROVED
      @leafe.status = Leafe::PENDING
      @allocated_leafe = AllocatedLeafe.where(user_id: @leafe.user_id).last
      @allocated_leafe.used_leave -= @count
      @allocated_leafe.save
      flash[:notice] = "The Leave information has been changed successfully"
    else
      @leafe.status = Leafe::APPROVED
      @leafe.approve_time = @leafe.updated_at
      @allocated_leafe = AllocatedLeafe.find_by(user_id: @leafe.user_id)
      @allocated_leafe.used_leave += @count
      @allocated_leafe.save
      LeafeMailer.approved(@leafe).deliver_now
      flash[:notice] = "Leave has been approved successfully"
    end
    @leafe.save
    redirect_back(fallback_location: show_all_allocated_leafe_path(@leafe.user_id))
  end

  def reject
    @leafe = Leafe.find(params[:id])
    @leafe.status = Leafe::REJECTED
    flash[:notice] = "The Leave information has been changed successfully"
    @leafe.save
    LeafeMailer.rejected(@leafe).deliver_now
    redirect_back(fallback_location: show_all_allocated_leafe_path(@leafe.user_id))
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status)
  end


end
