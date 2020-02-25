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

    @leaves_pending = @leaves.pending.paginate(:page => params[:pending_leaves], :per_page => Leafe::PER_PAGE)
    @leaves_approved = @leaves.approved.paginate(:page => params[:approved_leaves], :per_page => Leafe::PER_PAGE)
    @leaves_rejected = @leaves.rejected.paginate(:page => params[:rejected_leaves], :per_page => Leafe::PER_PAGE)
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
    if @leafe && @leafe.destroy
    redirect_to show_all_allocated_leafe_path(current_user.allocated_leafe), notice: 'Information has heen destroyed'
    else
      flash[:alert] = 'Leave could not be deleted!!'
      render :index
    end
  end

  def approve
    if @leafe.approved?
      @leafe.pending!
      flash[:notice] = 'Leave information has been changed successfully'
    else
      @leafe.approved!
      #LeafeMailer.approved(@leafe).deliver_now
      flash[:notice] = 'The leave has been approved successfully'
    end
    @leafe.update_allocated_leave
    redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe)
  end

  def reject
    @leafe.rejected!
    #LeafeMailer.rejected(@leafe).deliver_now
    redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe), notice: 'The leave has been changed successfully'
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status)
  end


end
