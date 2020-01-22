class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  # before_action :check, except: [:index, :show, :new, :create]
  # def check
  #   if current_user.role != User::ADMIN
  #     @expense = Expense.find(params[:id])
  #     if @expense.user_id != current_user.id
  #       redirect_to expenses_path, notice: "Access Denied"
  #     end
  #   end
  # end

  def index
    @expenses = Expense.order('expenses.id ASC').paginate(:page => params[:page], :per_page => 2)
  end

  def new

  end

  def create
    @expense.user_id = current_user.id
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
    redirect_to expenses_path, notice: "Expense has been removed successfully"
  end

  def edit

  end

  def update
    if @expense.update(expense_params)
      redirect_to expense_path,notice: "Expense has been updated successfully"
    else
      render 'edit'
    end
  end

  def approve
    @date = Date.today
    @month=@date.strftime("%b")
    @year=@date.strftime("%Y")
    @budget=Budget.find_by({year: @year, month: @month})
    if @expense.status == Expense::APPROVED
      @expense.status = Expense::PENDING
      @budget.remaining = @budget.remaining + @expense.cost
      flash[:notice] = "The Expense information has been changed successfully"
    else
      @expense.status = Expense::APPROVED
      @budget.remaining = @budget.remaining - @expense.cost
      flash[:notice] = "Expense has been approved successfully"
    end
    @budget.save
    @expense.save
    redirect_to expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:name, :category, :cost, :details)
  end


end
