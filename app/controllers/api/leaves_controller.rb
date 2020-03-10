class Api::LeavesController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def index
    raise "fff"
    @leaves = @leaves.all.includes(:user).order(id: :asc)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @leaves = @leaves.joins(:user).where('users.name ilike :search OR leave_type ilike :search', {search: search})
    end

    @leaves = @leaves.where(':from <= end_date ', {from: params[:from]}) if params[:from].present?
    @leaves = @leaves.where(':to >= start_date ', {to: params[:to]}) if params[:to].present?

    #render json: {pending: @leaves_pending, approved: @leaves_approved, rejected: @leaves_rejected}

  end

  def create
    @leafe = current_user.leaves.new(leafe_params)
    if @leafe.user.allocated_leafe.present?
      days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
      if days > 0 && @leafe.check_validity_of_leave(days)
        if @leafe.save
          render :show, status: :created, location: @leafe
        else
          render json: @leafe.errors, status: :unprocessable_entity
        end
      else
        render json: { error: "Please select a valid date range" }, status: 422
      end
    else
      render json: { error: "Leave for this user has not been allocated yet" }, status: 422
    end
  end

  def show
    @leafe = Leafe.find(params[:id])
  end

  def update
    @leafe = Leafe.find(params[:id])

    if @leafe.update(leafe_params)
      render :show, status: :ok, location: @leafe
    else
      render json: @leafe.errors, status: :unprocessable_entity
    end
  end

  def destroy

  end

  def approve
    if @leafe.user.allocated_leafe
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
    else
      redirect_to leaves_path, alert: 'Leave for this user has not been allocated yet.'
    end
  end

  def reject
    @leafe.rejected!
    #LeafeMailer.rejected(@leafe).deliver_now
    redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe), notice: 'The leave has been changed successfully'
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status, :user_id)
  end



end
