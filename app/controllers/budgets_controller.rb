class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :show_all, only: [:show_all_expenses]

  def copy_budget
    budgets = Budget.where(month: params[:month].to_i)
    last_budget = Budget.order(year: :desc).order(month: :desc).first
    next_month = last_budget.month + 1
    year = last_budget.year
    budgets.each do |budget|
      new_budget = budget.dup
      new_budget.expense = 0.0
      if next_month <=12
        new_budget.month = next_month
        new_budget.year = year
      else
        new_budget.month = 1
        new_budget.year = year + 1
      end
      new_budget.save
    end
    redirect_to budgets_path, notice: 'Budget has been created successfully!!'
  end

  def index
    @year = params[:search].present? ? "#{params[:search]}" : Date.today.year
    @budgets = @budgets.includes(:user).where(year: @year)
    @budget_amount = @budgets.group(:month).order(:month).sum(:amount)
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
    month = @budget.month
    year = @budget.year
    if @budget.update(budget_params)
      redirect_to show_all_budgets_path(month: month, year: year), notice: 'Budget has been updated successfully!!'
    else
      render :edit
    end
  end

  def destroy
    month = @budget.month
    year = @budget.year
    if @budget && @budget.destroy
      flash[:alert] = 'Budget has been removed successfully!!'
    else
      flash[:alert] = 'Budget could not be deleted!!'
    end
    redirect_to show_all_budgets_path(month: month, year: year)
  end

  def show_all_expenses
    @expenses = Expense.where('extract(year from expense_date) = ?', @year)
    @expenses = @expenses.includes(:user).where('extract(month from expense_date) = ?', @month)

    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user).where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.order(expense_date: :desc)

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