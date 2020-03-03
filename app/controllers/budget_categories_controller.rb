class BudgetCategoriesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index

  end

  def new

  end

  def create
    @budget_category = Expenses.new(expense_params)
    if @budget_category.save
      redirect_to expenses_path, notice: 'Expense has been created successfully!!'
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'Expense has been updated successfully!!'
    else
      render :edit
    end
  end

  def destroy
    if @expense && @expense.destroy
      flash[:alert] = 'Expense has been removed successfully!!'
    else
      flash[:alert] = 'Expense could not be deleted!!'
    end
    redirect_back(fallback_location: expenses_path)
  end


  def approve
    if @expense.approved?
      @expense.pending!
      flash[:warning] = 'The Expense has been queued for pending!!'
    else
      @expense.approved!
      flash[:notice] = 'Expense has been approved successfully!!'
    end
    @expense.update_budget
    redirect_back(fallback_location: expenses_path)
  end

  def reject
    @expense.rejected!
    redirect_back(fallback_location: expenses_path, alert: 'Expense has been rejected successfully!!')
  end

  private
  def expense_params
    params.require(:expense).permit(:product_name, :category, :cost, :details, :image, :expense_date)
  end


end
