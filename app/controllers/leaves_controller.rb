class LeavesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @leaves = @leaves.includes(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @leaves = @leaves.where('users.name ilike :search OR leave_type ilike :search', {search: search})
    end

    @leaves = @leaves.where(':from <= end_date ', {from: params[:from]}) if params[:from].present?
    @leaves = @leaves.where(':to >= start_date ', {to: params[:to]}) if params[:to].present?

    @leaves_pending = @leaves.Pending.paginate(:page => params[:pending_leaves], :per_page => 20)
    @leaves_approved = @leaves.Approved.paginate(:page => params[:approved_leaves], :per_page => 20)
    @leaves_rejected = @leaves.Rejected.paginate(:page => params[:rejected_leaves], :per_page => 20)
  end

  def new
    @leafe = current_user.leaves.new
  end

  def create
    @leafe = current_user.leaves.new(leafe_params)
    if Leafe.count_days(@leafe.start_date,@leafe.end_date) > 0
      if @leafe.save
        redirect_to leaves_path, notice: 'Your leave application has been submitted for approval'
      else
        render :new
      end
    else
      flash[:warning] = 'Please select a valid date range!!'
      render :new
    end

  end

  def edit

  end

  def show

  end

  def update
    if @leafe.update(leafe_params)
      redirect_to show_all_allocated_leafe_path(current_user.allocated_leafe), notice: 'Leave information has been updated'
    else
      render :edit
    end
  end

  def destroy
    @leafe.destroy
    redirect_to show_all_allocated_leafe_path(current_user.allocated_leafe), notice: 'Information has heen destroyed'
  end

  def approve
    @allocated_leafe = @leafe.user.allocated_leafe
    @count = Leafe.count_days(@leafe.start_date,@leafe.end_date)
    if @leafe.Approved?
      @leafe.Pending!
      @leafe.approve_time = nil
      @allocated_leafe.used_leave -= @count
      flash[:notice] = 'Leave information has been changed successfully'
    else
      @leafe.Approved!
      @leafe.approve_time = DateTime.now
      @allocated_leafe.used_leave += @count
      #LeafeMailer.approved(@leafe).deliver_now
      flash[:notice] = 'The leave has been approved successfully'
    end
    @leafe.save
    @allocated_leafe.save
    redirect_to show_all_allocated_leafe_path(@allocated_leafe)
  end

  def reject
    @leafe.Rejected!
    @leafe.save
    #LeafeMailer.rejected(@leafe).deliver_now
    redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe), notice: 'The leave has been changed successfully'
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status)
  end


end
