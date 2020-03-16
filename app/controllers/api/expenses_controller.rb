class Api::ExpensesController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def index
    @expenses = @expenses.includes(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user,:category)
                    .where('users.name ilike :search OR product_name ilike :search OR categories.name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.sort_by_attr(:expense_date)
    @pending_expenses = @expenses.pending
    @approved_expenses = @expenses.approved
    @rejected_expenses = @expenses.rejected
  end

  def new

  end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      render json: { message: "Expense has been created successfully!!" , url: api_expense_url(@expense, format: :json) }, status: 201
    else
      render json: { errors: @expense.errors }, status: 422
    end
  end

  def show
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      render json: { message: "Expense has been updated successfully!!" , url: api_expense_url(@expense, format: :json) }, status: 202
    else
      render json: { errors: @expense.errors }, status: 422
    end
  end

  def destroy
    if @expense && @expense.destroy
      render json: { message: "Expense has been removed successfully!!" }, status: 202
    else
      render json: { message: "Expense could not be deleted!!" }, status: 422
    end
  end

  def approve
    if @expense.approved?
      @expense.pending!
      render json: { message: "The Expense has been queued for pending!!" , url: api_expense_url(@expense, format: :json) }, status: 202
    else
      @expense.approved!
      render json: { message: "Expense has been approved successfully!!" , url: api_expense_url(@expense, format: :json)}, status: 202
    end
    @expense.update_budget
  end

  def reject
    @expense.rejected!
    render json: { message: "Expense has been rejected successfully!!" , url: api_expense_url(@expense, format: :json) }, status: 202
  end

  private
  def expense_params
    params.require(:expense).permit(:product_name, :category_id, :cost, :details, :image, :expense_date, :user_id)
  end

end
