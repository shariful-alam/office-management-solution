class Manage::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show_all_pending
    @all_pending_expenses =  Expense.Pending.order('expenses.id ASC').paginate(:page => params[:page], :per_page => 20)
    @all_pending_leaves =  Leafe.Pending.order('leaves.id ASC').paginate(:page => params[:page], :per_page => 20)
    @all_pending_incomes =  Income.Pending.order('incomes.id ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def new
  end

  def create
    if @user.save
      redirect_to manage_users_path, notice: 'User has been created successfully'
    else
      render 'new'
    end
  end

  def index
    if params[:search].present?
      search = "%#{params[:search]}%"
      @users = @users.where('name ilike :search OR email ilike :search OR phone ilike :search OR role ilike :search', {search: search})
    end
    @users = @users.order('id ASC').paginate(:page => params[:page], :per_page => 20)
    #raise @users.to_sql
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to manage_users_path, alert: 'User has been removed successfully'
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to manage_user_path, notice: 'User data has been updated successfully'
    else
      render 'edit'
    end
  end

  def show_all
    @expenses = @user.expenses
    @expense_for_user = Expense.where(status: 'Approved').sum(:cost)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user).where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.order('id ASC')
    @pending_expenses = @expenses.Pending.paginate(:page => params[:page], :per_page => 20)
    @approved_expenses = @expenses.Approved.paginate(:page => params[:page], :per_page => 20)
    @rejected_expenses = @expenses.Rejected.paginate(:page => params[:page], :per_page => 20)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :designation, :role, :password, :password_confirmation, :image, :remove_image, :target_amount,:bonus_percentage)
  end


end
