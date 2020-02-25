class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @budgets = @budgets.includes(:user)
    @year = params[:search].present? ? "#{params[:search]}" : Date.today.year
    @budgets = @budgets.where(year: @year).order(:year, :month).paginate(:page => params[:page], :per_page => Budget::PER_PAGE)
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
    @expenses = @budget.expenses.includes(:user)
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

  def destroy
     if @budget && @budget.destroy
       flash[:alert] = 'Budget has been removed successfully!!'
     else
       flash[:alert] = 'Budget could not be deleted!!'
     end
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