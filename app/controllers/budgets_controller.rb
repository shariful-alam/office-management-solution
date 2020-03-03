class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :show_all, only: [:show_all_expenses]

  def index
    @year = params[:search].present? ? "#{params[:search]}" : Date.today.year
    @budgets = @budgets.where(year: @year)
    @budget_amount = @budgets.group(:month).sum(:amount)
    @budget_expense = @budgets.group(:month).sum(:expense)
    @budgets = @budgets.order(:year, :month).paginate(:page => params[:page], :per_page => Budget::PER_PAGE)
  end

  def new
  end

  def create
    @budget = current_user.budgets.new(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: 'Budget has been created successfully!!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: 'Budget has been updated successfully!!'
    else
      render :edit
    end
  end

  def destroy
    if @budget && @budget.destroy
      flash[:alert] = 'Budget has been removed successfully!!'
    else
      flash[:alert] = 'Budget could not be deleted!!'
    end
    redirect_to budgets_path
  end

  def show_all_expenses
    @expenses = Expense.where('extract(year from expense_date) = ?', @year)
    @expenses = @expenses.where('extract(month from expense_date) = ?', @month)

    if params[:search].present?
      search = '%#{params[:search]}%'
      @expenses = @expenses.where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.sort_by_attr(:expense_date)

    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => Expense::PER_PAGE)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => Expense::PER_PAGE)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => Expense::PER_PAGE)
  end

  def show_all
    @year = "#{params[:year]}".to_i
    @month = "#{params[:month]}".to_i
    @budgets = @budgets.search_with(@year, @month)
    @total_amount = @budgets.sum(:amount)
    @total_expense = @budgets.sum(:expense)
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount, :add, :category_id)
  end

end