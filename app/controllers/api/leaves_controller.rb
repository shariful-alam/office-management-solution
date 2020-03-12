class Api::LeavesController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def index
    @leaves = @leaves.includes(:user).order(id: :asc)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @leaves = @leaves.joins(:user).where('users.name ilike :search OR leave_type ilike :search', {search: search})
    end

    @leaves = @leaves.where(':from <= end_date ', {from: params[:from]}) if params[:from].present?
    @leaves = @leaves.where(':to >= start_date ', {to: params[:to]}) if params[:to].present?

    @leaves = @leaves.paginate(:page => params[:rejected_leaves], :per_page => Leafe::PER_PAGE)
  end

  def create
    @leafe = current_user.leaves.new(leafe_params)
    if @leafe.user.allocated_leafe.present?
      days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
      if days > 0 && @leafe.check_validity_of_leave(days)
        if @leafe.save
          if current_user.admin? || current_user.super_admin?
            render json: {message: "Leave has been created", url: api_leafe_url(@leafe, format: :json)}, status: :created
          else
            render json: {message: "Leave has been submitted for approval", url: api_leafe_url(@leafe, format: :json)}, status: :created
          end
        else
          render json: @leafe.errors, status: :unprocessable_entity
        end
      else
        render json: {error: "Please select a valid date range"}, status: 422
      end
    else
      render json: {error: "Leave for this user has not been allocated yet"}, status: 422
    end
  end

  def show

  end

  def edit

  end

  def update
    if @leafe.update(leafe_params)
      render json: {message: "Leave has been updated", url: api_leafe_url(@leafe, format: :json)}, status: :created
    else
      render json: @leafe.errors, status: 422
    end
  end

  def destroy
    if @leafe && @leafe.destroy
      render json: {message: "Leave has been destroyed"}, status: :ok
    else
      render json: {error: "Leave could not be deleted!!"}, status: 422
    end
  end

  def approve
    if @leafe.user.allocated_leafe
      if @leafe.approved?
        @leafe.pending!
        render json: {message: "Leave information has been changed successfully"}, status: :ok
      else
        @leafe.approved!
        render json: {message: "The leave has been approved successfully"}, status: :ok
      end
      @leafe.update_allocated_leave
    else
      render json: {message: "Leave for this user has not been allocated yet"}
    end
  end

  def reject
    @leafe.rejected!
    render json: {message: "Leave has been rejected"}, status: :ok
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status, :user_id)
  end


end
