class Manage::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show_all_pending
    @all_pending_expenses =  Expense.where(status: 'Pending').order('expenses.id ASC').paginate(:page => params[:page], :per_page => 20)
    @all_pending_leaves =  Leafe.where(status: 'Pending').order('leaves.id ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to manage_users_path, notice: "User has been created successfully"
    else
      render 'new'
    end
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).order('users.id ASC').paginate(:page => params[:page], :per_page => 2)
    else
      @users = User.order('users.id ASC').paginate(:page => params[:page], :per_page => 2)
    end
    #raise @users.to_sql
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to manage_users_path, notice: "User has been removed successfully"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to manage_user_path, notice: "User data has been updated successfully"
    else
      render 'edit'
    end
  end

  def show_all
    @expense_for_user=Expense.where(user_id: params[:id], status: 'Approved').sum(:cost)
    @approved_expenses = Expense.user_expenses(params[:search], params[:page], params[:id], params[:status]='Approved')
    @pending_expenses = Expense.user_expenses(params[:search], params[:page], params[:id], params[:status]='Pending')
    @rejected_expenses = Expense.user_expenses(params[:search], params[:page], params[:id], params[:status]='Rejected')
  end

  def search_by_date
    @approved_expenses = Expense.user_expenses_date_search(params[:from], params[:to], params[:page], params[:id], params[:status]='Approved')
    @pending_expenses = Expense.user_expenses_date_search(params[:from], params[:to], params[:page], params[:id], params[:status]='Pending')
    @rejected_expenses = Expense.user_expenses_date_search(params[:from], params[:to], params[:page], params[:id], params[:status]='Rejected')
    @total=Expense.where(budget_id: params[:id], status: 'Approved').sum(:cost)
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :role, :password, :password_confirmation, :image, :remove_image, :target_amount,:bonus_percentage)
  end


end
