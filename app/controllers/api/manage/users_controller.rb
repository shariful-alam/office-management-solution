class Api::Manage::UsersController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def show_all_pending
    @all_pending_expenses = Expense.pending.includes(:user).order(:id).paginate(:page => params[:pending_expenses], :per_page => 20)
    @all_pending_leaves = Leafe.pending.includes(:user).order(:id).paginate(:page => params[:pending_leaves], :per_page => 20)
    @all_pending_incomes = Income.pending.includes(:user).order(:id).paginate(:page => params[:pending_incomes], :per_page => 20)
  end

  def create
    if @user.save
      render json: { message: "User has been created successfully" , url: api_manage_user_url(@user, format: :json) }, status: 201
    else
      render json: @user.errors, status: 422
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
      render json: {message: "User has been removed successfully!!"}, status: :ok
    else
      render json: {error: "User could not be deleted"}, status: 422
    end
  end

  def edit
  end

  def update
    if @user && @user.update(user_params)
      render json: { message: "User data has been updated successfully" , url: api_manage_user_url(@user, format: :json) }, status: 202
    else
      render json: @user.errors, status: 422
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
    @expenses = @expenses.order(expense_date: :desc)
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
