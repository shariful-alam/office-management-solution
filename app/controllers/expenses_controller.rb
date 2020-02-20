class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = @expenses.joins(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.order(:id)
    @pending_expenses = @expenses.Pending.paginate(:page => params[:pending_expenses], :per_page => 20)
    @approved_expenses = @expenses.Approved.paginate(:page => params[:approved_expenses], :per_page => 20)
    @rejected_expenses = @expenses.Rejected.paginate(:page => params[:rejected_expenses], :per_page => 20)
  end

  def new

  end

  def create
    @expense = current_user.expenses.new(expense_params)
    @budget = Budget.find_by(month: @expense.expense_date.month, year: @expense.expense_date.year) if @expense.expense_date.present?
    @expense.budget = @budget if @budget.present?
    if @expense.save
      redirect_to expenses_path, success: 'Expense has been created successfully!!'
    else
      if @expense.expense_date.nil?
        render :new
      else
        redirect_to expenses_path, alert: "Budget for #{Date::MONTHNAMES[@expense.expense_date.month]} is not submitted yet!!"
      end
    end
  end

  def show

  end

  def destroy
    @expense.destroy
    flash[:alert] = 'Expense has been removed successfully!!'
    redirect_back(fallback_location: expenses_path)
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      @budget = Budget.find_by(month: @expense.expense_date.month, year: @expense.expense_date.year) if @expense.expense_date.present?
      @expense.budget = @budget if @budget.present?
      if @expense.save
        redirect_to expenses_path, success: 'Expense has been updated successfully!!'
      else
        render :edit, alert: 'The budget for this month is not submitted yet!!'
      end
    else
      render :edit
    end
  end

  def reject
    @expense.Rejected!
    @expense.save
    flash[:alert] = 'Expense has been rejected successfully!!'
    redirect_back(fallback_location: expenses_path)
  end

  def approve
    if @expense.Approved?
      @expense.Pending!
      @expense.budget.expense = @expense.budget.expense - @expense.cost
      @expense.approve_time = nil
      flash[:warning] = 'The Expense has been queued for pending!!'
    else
      @expense.Approved!
      @expense.approve_time = @expense.updated_at
      @expense.budget.expense = @expense.budget.expense + @expense.cost
      flash[:notice] = 'Expense has been approved successfully!!'
    end
    @expense.budget.save
    @expense.save
    redirect_back(fallback_location: expenses_path)
  end


  private
  def expense_params
    params.require(:expense).permit(:product_name, :category, :cost, :details, :image, :expense_date)
  end

end
