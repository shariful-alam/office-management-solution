class Api::IncomesController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def index
    @users_income = User.paginate(:page => params[:users_incomes], :per_page => Income::PER_PAGE)
    @users_bonus = @users_income.paginate(:page => params[:users_bonuses], :per_page => Income::PER_PAGE)

    @monthly_totals = Array.new(15,0)
    @all_incomes = []
    @all_bonuses = []
    @total_income_per_user = Array.new

    @users_income.each do |user|
      @temp_income = []
      @temp_bonus = []
      Income::MONTHS.each do |month|
        @temp_income << Income.find_incomes_by_months(user,month+1,params[:search])
        @temp_bonus << Income.bonus_amount(user,month+1,params[:search])
      end
      @all_incomes[user.id] = @temp_income
      @all_bonuses[user.id] = @temp_bonus
      @total_income_per_user[user.id] = Income.find_total(user,params[:search])
    end
  end

  def create
    @income = current_user.incomes.new(income_params)
    if @income.save
      if current_user.admin? || current_user.super_admin?
        render json: {message: "Income has been created successfully", url: api_income_url(@income, format: :json)}, status: :created
      else
        render json: {message: "Income has been submitted for approval", url: api_income_url(@income, format: :json)}, status: :created
      end
    else
      render json: @income.errors, status: 422
    end

  end

  def edit

  end

  def update
    if @income && @income.update(income_params)
      render json: {message: "Income information has been updated", url: api_income_url(@income, format: :json)}, status: :created
    else
      render json: @income.errors, status: 422
    end
  end

  def show

  end


  def destroy
    if @income && @income.destroy
      render json: {message: "Income information has been destroyed"}, status: :ok
    else
      render json: {error: "Income could not be deleted!!"}, status: 422
    end
  end

  def approve
    if @income.approved?
      @income.pending!
      render json: {message: "The income status has been changed successfully"}, status: :ok
    else
      @income.approved!
      render json: {message: "Income has been approved"}, status: :ok
    end
  end

  def reject
    @income.rejected!
    render json: {message: "Income has been rejected"}, status: :ok
  end


  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :source, :search)
  end

end