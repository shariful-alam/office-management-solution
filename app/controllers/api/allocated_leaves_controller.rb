class Api::AllocatedLeavesController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def index
    @allocated_leaves = @allocated_leaves.includes(:user).where(year: params[:search].present? ? params[:search] : Date.today.year.to_s)
  end

  def new

  end

  def create
    if @allocated_leafe.save
      render json: {message: "Leave has been allocated successfully!!", url: api_allocated_leafe_url(@allocated_leafe, format: :json)}, status: 201
    else
      render json: @allocated_leafe.errors, status: 422
    end
  end

  def show
    @allocated_leaves = @allocated_leafe.allocated_leaves_count_for(@allocated_leafe.user)
    render json: {allocated_leaves: @allocated_leaves}
  end

  def edit

  end

  def update
    if @allocated_leafe.update(allocated_leafe_params)
      render json: {message: "Your information has been updated successfully", url: api_allocated_leafe_url(@allocated_leafe, format: :json)}, status: 202
    else
      render json: @allocated_leafe.errors, status: 422
    end
  end

  def destroy
    if @allocated_leafe && @allocated_leafe.destroy
      render json: {message: "Information has been removed!!", index_url: api_allocated_leaves_url(format: :json)}, status: 202
    else
      render json: {message: "Information could not be deleted!!"}, status: 422
    end
  end

  def show_all
    @leaves = @allocated_leafe.user.leaves
    @leaves_pending = @leaves.pending
    @leaves_approved = @leaves.approved
    @leaves_rejected = @leaves.rejected
    render json: {leaves_pending: @leaves_pending, leaves_approved: @leaves_approved, leaves_rejected: @leaves_rejected}
  end

  private
  def allocated_leafe_params
    params.require(:allocated_leafe).permit(:user_id, :total_leave, :year)
  end

end
