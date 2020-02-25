class Manage::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show_all_pending
    @all_pending_expenses = Expense.pending.includes(:user).order(:id).paginate(:page => params[:pending_expenses], :per_page => 20)
    @all_pending_leaves = Leafe.pending.includes(:user).order(:id).paginate(:page => params[:pending_leaves], :per_page => 20)
    @all_pending_incomes = Income.pending.includes(:user).order(:id).paginate(:page => params[:pending_incomes], :per_page => 20)
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
    @users = @users.order(:id).paginate(:page => params[:page], :per_page => 20)
    #raise @users.to_sql
  end

  def show
  end

  def destroy
    flash[:alert] = 'User has been removed successfully!!' if @user.destroy
    redirect_to manage_users_path
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
    @expense_for_user = @expenses.approved.sum(:cost)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.joins(:user).where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    if params[:from].present? and params[:to].present?
      @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]})
    end
    @expenses = @expenses.sort_by_attr(:expense_date)
    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => 20)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => 20)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => 20)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :designation, :role, :password,
                                 :password_confirmation, :image, :remove_image, :target_amount,
                                 :bonus_percentage)
  end


end
