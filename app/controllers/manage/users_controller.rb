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
  end

  def show
  end

  def destroy
    if @user && @user.destroy
      flash[:alert] = 'User has been removed successfully!!'
      redirect_to manage_users_path
    else
      flash[:alert] = 'User could not be deleted'
      render :index
    end
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

  def show_all_expenses
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
    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => Expense::PER_PAGE)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => Expense::PER_PAGE)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => Expense::PER_PAGE)
  end

  def show_all_incomes

    @incomes = @user.incomes
    #used pg specific query to reduce complexity
    @incomes = @incomes.find_in_income_date_by('month', params[:month]) if params[:month].present?
    @incomes = @incomes.find_in_income_date_by('year', params[:year].present? ? params[:year] : Date.today.year)

    @incomes = @incomes.where('income_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?

    @incomes = @incomes.order(income_date: :desc)

    @incomes_approved = @incomes.approved.paginate(:page => params[:approved_incomes], :per_page => Income::PER_PAGE)
    @incomes_pending = @incomes.pending.paginate(:page => params[:pending_incomes], :per_page => Income::PER_PAGE)
    @incomes_rejected = @incomes.rejected.paginate(:page => params[:rejected_incomes], :per_page => Income::PER_PAGE)

    @bonus_amount = Income.bonus_amount(@user,params[:month],params[:year]) if params[:month].present?
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :designation, :role, :password,
                                 :password_confirmation, :image, :remove_image, :target_amount,
                                 :bonus_percentage)
  end


end
