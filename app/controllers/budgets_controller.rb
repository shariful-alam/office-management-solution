class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @budgets = @budgets.joins(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @budgets = @budgets.where('users.name ilike :search OR month ilike :search', {search: search})
    end
    @budgets = @budgets.order('id ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def new
  end

  def create
    @budget = current_user.budgets.new(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: "Budget has been Created Successfully!!"
    else
      render 'new'
    end
  end

  def show
    @expenses = Expense.where(budget_id: params[:id])

    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user).where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.order('id ASC')

    @pending_expenses = @expenses.with_status(Expense::PENDING).paginate(:page => params[:page], :per_page => 20)
    @approved_expenses = @expenses.with_status(Expense::APPROVED).paginate(:page => params[:page], :per_page => 20)
    @rejected_expenses = @expenses.with_status(Expense::REJECTED).paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    @budget.destroy
    redirect_to budgets_path, alert: "Budget has been Removed!!"
  end

  def edit
    @budget.year=@budget.month.chars.last(4).join
    @budget.month=@budget.month[0...-6]
  end

  def update
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: "Budget has been Updated Successfully!!"
    else
      render 'edit'
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount ,:add)
  end

end