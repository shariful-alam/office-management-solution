class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index

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

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.new(expense_params)
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
      else
        redirect_to expenses_path, alert: "The budget for this month is not submitted yet!!"
      end
      @expense.save
      redirect_to expenses_path, success: "Expense has been Updated Successfully!!"
    else
      render 'edit'
    end
  end

  def reject
    @expense.status = Expense::REJECTED
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


  private
  def expense_params
    params.require(:expense).permit(:product_name, :category, :cost, :details, :image, :expense_date)
  end

end
