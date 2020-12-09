class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = @expenses.includes(:user).order(created_at: :desc)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user).where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.order(expense_date: :desc)
    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => Expense::PER_PAGE)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => Expense::PER_PAGE)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => Expense::PER_PAGE)

    date = Date.today
    year = date.year.to_i
    month = date.month.to_i
    @budgets = Budget.search_with(year, month)

    if @budgets.present?
      @total_amount = @budgets.sum(:amount)
      @total_expense = @budgets.sum(:expense)
    end

  end

  def new

  end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      if current_user.admin? || current_user.super_admin?
        redirect_to expenses_path, notice: 'Expense has been created successfully!!'
      else
        redirect_to new_expense_path, notice: 'Expense has been submitted for approval'
      end
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    updated_budget = @expense.budget.expense + expense_params[:cost].to_i - @expense.cost if @expense.approved?
    if @expense.update(expense_params)
      @expense.budget.update({expense: updated_budget}) if @expense.approved?
      redirect_to expenses_path, notice: 'Expense has been updated successfully!!'
    else
      render :edit
    end
  end

  def destroy
    if @expense.approved?
      @budget = @expense.budget
      updated_budget = @budget.expense - @expense.cost
    end
    if @expense && @expense.destroy
      @budget.update({expense: updated_budget}) if @expense.approved?
      flash[:alert] = 'Expense has been removed successfully!!'
    else
      flash[:alert] = 'Expense could not be deleted!!'
    end
    redirect_back(fallback_location: expenses_path)
  end

  def approve
    if @expense.approved?
      @expense.pending!
      flash[:warning] = 'The Expense has been queued for pending!!'
    else
      @expense.approved!
      flash[:notice] = 'Expense has been approved successfully!!'
    end
    @expense.update_budget
    redirect_back(fallback_location: expenses_path)
  end

  def reject
    @expense.rejected!
    redirect_back(fallback_location: expenses_path, alert: 'Expense has been rejected successfully!!')
  end

  private

  def expense_params
    params.require(:expense).permit(:product_name, :category_id, :cost, :details, :image, :expense_date)
  end

end
