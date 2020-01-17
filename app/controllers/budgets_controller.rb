class BudgetsController < ApplicationController

  before_action :authenticate_user!

  before_action :check, except: [:index]

  def check
    if current_user.role!=User::ADMIN
      redirect_to budgets_path
    end
  end

  def index
    @budgets = Budget.order('budgets.id ASC').all
  end

  def new
    @budget=Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.remaining=@budget.amount
    @budget.user_id=current_user.id
    if @budget.save
      flash[:notices] = "Expense was created successfully"
      redirect_to budgets_path
    else
      render 'new'
    end
  end

  def show
    @budget = Budget.find(params[:id])
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    flash[:notices] = "Expense was removed successfully"
    redirect_to budgets_path
  end

  def edit
    @budget = Budget.find(params[:id])

  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      flash[:notices] = "Expense was updated successfully"
      redirect_to budget_path
    else
      render 'edit'
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount, :remaining, :user_id)
  end

end