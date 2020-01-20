class ExpensesController < ApplicationController

  before_action :authenticate_user!
  before_action :check, except: [:index, :show, :new, :create]

  def check

    if current_user.role!=User::ADMIN
      @expense = Expense.find(params[:id])
      if @expense.user_id!=current_user.id
        flash[:notice] = "Access Denied"
        redirect_to expenses_path
      end
    end
  end

  def index
    @expenses = Expense.order('expenses.id ASC').all
    @total= @expenses.sum(:cost)
  end

  def new
    @expense=Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    if @expense.save
      flash[:notice] = "Expense has been created successfully"
      redirect_to expenses_path
    else
      render 'new'
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:notice] = "Expense has been removed successfully"
    redirect_to expenses_path
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      flash[:notice] = "Expense has been updated successfully"
      redirect_to expense_path
    else
      render 'edit'
    end
  end

  def approve
    @expense = Expense.find(params[:id])
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
    params.require(:expense).permit(:name, :category, :cost, :details, :user_id)
  end


end
