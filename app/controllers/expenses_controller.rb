class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = Expense.search(params[:search], params[:page], params[:user_id] = current_user.id, params[:role] = current_user.role)
  end

  def new

  end

  def create
    @expense.user_id = current_user.id
    if @expense.late == '1'
      @month = @expense.month+', '+@expense.year
      @budget=Budget.find_by(month: @month)
      if @budget
        @expense.budget_id=@budget.id
      end
    else
      @date = Date.today
      @month=@date.strftime("%B")+', '+@date.strftime("%Y")
      @budget=Budget.find_by(month: @month)
      if @budget
        @expense.budget_id=@budget.id
      end
    end

    if @expense.save
      redirect_to expenses_path, notice: "Expense has been created successfully"
    else
      render 'new'
    end
  end

  def show

  end

  def destroy
    @expense.destroy
    flash[:notice] = "Expense has been removed successfully"
    redirect_back(fallback_location: expenses_path)
  end

  def edit

  end

  def update
    if @expense.update(expense_params)
      flash[:notice] = "Expense has been updated successfully"
      redirect_back(fallback_location: expenses_path)
    else
      render 'edit'
    end
  end

  def reject
    if @expense.status != Expense::REJECTED
      @expense.status = Expense::REJECTED
    end
    @expense.save
    flash[:notice] = "Expense has been rejected successfully"
    redirect_back(fallback_location: expenses_path)
  end

  def approve
    @budget = Budget.find(@expense.budget_id)
    if @expense.status == Expense::APPROVED
      @expense.status = Expense::PENDING
      @budget.expense = @budget.expense - @expense.cost
      @expense.approve_time = nil
      flash[:notice] = "The Expense information has been changed successfully"
    else
      @expense.status = Expense::APPROVED
      @expense.approve_time = @expense.updated_at
      @budget.expense = @budget.expense + @expense.cost
      flash[:notice] = "Expense has been approved successfully"
    end
    @budget.save
    @expense.save
    redirect_back(fallback_location: expenses_path)
  end

  private
  def expense_params
    params.require(:expense).permit(:product_name, :category, :cost, :details, :image, :year, :month, :late)
  end


end
