class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @budgets = @budgets.includes(:user)
    @year = params[:search].present? ? "#{params[:search]}" : Date.today.year
    @budgets = @budgets.where(year: @year).order(:year, :month).paginate(:page => params[:page], :per_page => 12)
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

  def show
    @expenses = @budget.expenses
    @expenses = @expenses.includes(:user)
    if params[:search].present?
      search = '%#{params[:search]}%'
      @expenses = @expenses.where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.sort_by_expense_date

    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => 20)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => 20)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => 20)
  end

  def destroy
    flash[:alert] = 'Budget has been removed successfully!!' if @budget.destroy
    redirect_to budgets_path
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

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount, :add)
  end

end