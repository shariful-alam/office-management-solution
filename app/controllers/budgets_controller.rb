class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    if params[:search]
      @budgets = Budget.search(params[:search]).order('budgets.id ASC').paginate(:page => params[:page], :per_page => 12) #raise @budgets.to_sql
    else
      @budgets = Budget.order('budgets.id ASC').paginate(:page => params[:page], :per_page => 12)
    end
  end

  def new
    @budget=Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    if @budget.save
      redirect_to budgets_path, notice: "Budget has been Created Successfully!!"
    else
      render 'new'
    end
  end

  def show
    @approved_expenses = Expense.budget_expenses(params[:search], params[:page], params[:id],params[:status]='Approved')
    @pending_expenses = Expense.budget_expenses(params[:search], params[:page], params[:id],params[:status]='Pending')
    @rejected_expenses = Expense.budget_expenses(params[:search], params[:page], params[:id],params[:status]='Rejected')
  end

  def search_by_date
    @approved_expenses = Expense.budget_expenses_date_search(params[:from], params[:to], params[:page], params[:id], params[:status]='Approved')
    @pending_expenses = Expense.budget_expenses_date_search(params[:from], params[:to], params[:page], params[:id], params[:status]='Pending')
    @rejected_expenses = Expense.budget_expenses_date_search(params[:from], params[:to], params[:page], params[:id], params[:status]='Rejected')
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    redirect_to budgets_path, alert: "Budget has been Removed!!"
  end

  def edit
    @budget = Budget.find(params[:id])
    @budget.year=@budget.month.chars.last(4).join
    @budget.month=@budget.month[0...-6]
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budget_path, notice: "Budget has been Updated Successfully!!"
    else
      render 'edit'
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount ,:add)
  end

end