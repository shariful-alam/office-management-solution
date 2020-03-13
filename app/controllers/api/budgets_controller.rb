class Api::BudgetsController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource
  before_action :show_all, only: [:show_all_expenses]

  def index
    @year = params[:search].present? ? "#{params[:search]}" : Date.today.year
    @budgets = @budgets.includes(:user).where(year: @year).order(:month)
    @budget_amount = @budgets.group(:month).sum(:amount)
    @budget_expense = @budgets.group(:month).sum(:expense)
  end

  def new
  end

  def create
    @budget = current_user.budgets.new(budget_params)
    if @budget.save
      render json: { message: "Budget has been created successfully!!" , url: api_budget_url(@budget, format: :json) }, status: 201
    else
      render json: @budget.errors, status: 422
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
      render json: { message: "Budget has been updated successfully!!" , url: api_budget_url(@budget, format: :json) }, status: 202
    else
      render json: @budget.errors, status: 422
    end
  end

  def destroy
    if @budget && @budget.destroy
      render json: { message: "Budget has been removed successfully!!", index_url: api_budgets_url(format: :json) }, status: 202
    else
      render json: { message: "Budget could not be deleted!!" }, status: 422
    end
  end

  def show_all_expenses
    @expenses = Expense.where('extract(year from expense_date) = ?', @year)
    @expenses = @expenses.where('extract(month from expense_date) = ?', @month)
    @expenses = @expenses.includes(:user)

    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user).where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.sort_by_attr(:expense_date)

    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => Expense::PER_PAGE)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => Expense::PER_PAGE)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => Expense::PER_PAGE)
  end

  def show_all
    @year = params[:year].to_i
    @month = params[:month].to_i
    @budgets = @budgets.search_with(@year, @month)
    @total_amount = @budgets.sum(:amount)
    @total_expense = @budgets.sum(:expense)
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount, :add, :category_id)
  end

end