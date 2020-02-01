class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if params[:from] != nil and params[:to] != nil
      @approved_expenses = Expense.expenses_date_search(params[:from], params[:to], params[:page], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]='Approved')
      @pending_expenses = Expense.expenses_date_search(params[:from], params[:to], params[:page], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]='Pending')
      @rejected_expenses = Expense.expenses_date_search(params[:from], params[:to], params[:page], params[:id] = current_user.id, params[:role] = current_user.role, params[:status]='Rejected')
    else
      @expenses=Expense.all.order('budgets.id ASC').paginate(:page => params[:page], :per_page => 12) #raise @budgets.to_sql
      @approved_expenses = Expense.search(params[:search], params[:page], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]='Approved')
      @pending_expenses = Expense.search(params[:search], params[:page], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]='Pending')
      @rejected_expenses = Expense.search(params[:search], params[:page], params[:user_id] = current_user.id, params[:role] = current_user.role, params[:status]='Rejected')
    end
  end

  def new

  end

  def create
    @expense.user_id = current_user.id
    month=@expense.expense_date.strftime("%B")+', '+@expense.expense_date.strftime("%Y")
    @budget=Budget.find_by(month: month)
    if @budget
      @expense.budget_id=@budget.id
    end
    if @expense.save
      redirect_to expenses_path, notice: "Expense has been Created Successfully!!"
    else
      render 'new'
    end
  end


  def show

  end

  def destroy
    @expense.destroy
    flash[:alert] = "Expense has been Removed!!"
    redirect_back(fallback_location: expenses_path)
  end

  def edit

  end

  def update
    if @expense.update(expense_params)
      month=@expense.expense_date.strftime("%B")+', '+@expense.expense_date.strftime("%Y")
      @budget=Budget.find_by(month: month)
      if @budget
        @expense.budget_id=@budget.id
      end
      @expense.save
      redirect_to expenses_path, success: "Expense has been Updated Successfully!!"
    else
      render 'edit'
    end
  end

  def reject
    if @expense.status != Expense::REJECTED
      @expense.status = Expense::REJECTED
    end
    @expense.save
    flash[:alert] = "Expense has been Rejected!!"
    redirect_back(fallback_location: expenses_path)
  end

  def approve
    @budget = Budget.find(@expense.budget_id)
    if @expense.status == Expense::APPROVED
      @expense.status = Expense::PENDING
      @budget.expense = @budget.expense - @expense.cost
      @expense.approve_time = nil
      flash[:warning] = "The Expense has been Queued for Pending!!"
    else
      @expense.status = Expense::APPROVED
      @expense.approve_time = @expense.updated_at
      @budget.expense = @budget.expense + @expense.cost
      flash[:notice] = "Expense has been Approved Successfully!!"
    end
    @budget.save
    @expense.save
    redirect_back(fallback_location: expenses_path)
  end

  def search_by_date
  end


  private
  def expense_params
    params.require(:expense).permit(:product_name, :category, :cost, :details, :image, :expense_date)
  end


end
