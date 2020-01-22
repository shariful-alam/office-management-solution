class BudgetsController < ApplicationController

  before_action :authenticate_user!

  before_action :check, except: [:index]

  def check
    if current_user.role != User::ADMIN
      redirect_to budgets_path, notice: "Access Denied"
    end
  end

  def index
    if params[:search]
      @budgets = Budget.search(params[:search]).order('budgets.id ASC').paginate(:page => params[:page], :per_page => 2)
      #raise @budgets.to_sql
    else
      @budgets = Budget.order('budgets.id ASC').paginate(:page => params[:page], :per_page => 2)
    end

  end

  def new
    @budget=Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.remaining = @budget.amount
    @budget.user_id = current_user.id
    if @budget.save
      redirect_to budgets_path, notice: "Budget has been created successfully"
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
    redirect_to budgets_path, notice: "Budget has been removed successfully"
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budget_path, notice: "Budget has been updated successfully"
    else
      render 'edit'
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount, :remaining, :user_id)
  end

end