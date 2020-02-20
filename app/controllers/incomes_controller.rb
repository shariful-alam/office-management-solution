class IncomesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users_income = User.order(:id).paginate(:page => params[:users_incomes], :per_page => 10)
    @users_bonus = @users_income.paginate(:page => params[:users_bonuses], :per_page => 10)

    @monthly_totals = Array.new(13,0)
    @all_incomes = Array.new(15){Array.new(15) { 0 } }
    @all_bonuses = Array.new(15){Array.new(15) { 0 } }
    @total_income_per_user = Array.new

    @users_income.each do |user|
      Income::MONTHS.each do |month|
        income = Income.find_incomes_by_months(user,month,params[:search])
        @all_incomes[user.id][month] = income
        @all_bonuses[user.id][month] = Income.bonus_amount(user,month,params[:search])
        #raise @all_incomes[user.id][month].inspect
      end
      @total_income_per_user[user.id] = Income.find_total(user,params[:search])
    end
  end

  def new

  end

  def create
    @income = current_user.incomes.new(income_params)
    if @income.save
      flash[:notice] = 'Your income has been submitted for approval'
      if current_user.admin?
        redirect_to incomes_path
      else
        redirect_to show_individual_incomes_path
      end
    else
      render :new
    end

  end

  def edit

  end

  def update
    if @income.update(income_params)
      flash[:notice] = 'Your income information has been updated'
      redirect_to show_individual_incomes_path(user_id: current_user.id, month: @income.income_date.month, year: params[:search])
    else
      render :edit
    end
  end

  def show

  end


  def destroy
    @income.destroy
    flash[:notice] = 'Your Income information has been destroyed'
    redirect_back(fallback_location: incomes_path)
  end

  def approve
    if @income.Approved?
      @income.Pending!
      flash[:notice] = 'The income status has been changed successfully'
    else
      @income.Approved!
      @income.approve_time = @income.updated_at
      #LeafeMailer.approved(@leave).deliver_now
      #raise @allocated_leave.inspect
      flash[:notice] = 'Income has been approved'
    end
    @income.save
    redirect_back(fallback_location: incomes_path)
  end

  def reject
    @income.Rejected!
    flash[:notice] = 'Income has been rejected'
    @income.save
    #LeafeMailer.rejected(@leave).deliver_now
    redirect_back(fallback_location: incomes_path)
  end

  def show_individual
    @user = current_user.admin? ? User.find(params[:user_id]) : current_user
    @incomes = @user.incomes

    @incomes = @incomes.where('extract(month from income_date) = ?', params[:month]) if params[:month].present?
    @incomes = @incomes.where('extract(year from income_date) = ?', params[:year].present? ? params[:year] : Date.today.year) if params[:year].present?

    @incomes_approved = @incomes.Approved.paginate(:page => params[:page], :per_page => 10)
    @incomes_pending = @incomes.Pending.paginate(:page => params[:page], :per_page => 10)
    @incomes_rejected = @incomes.Rejected.paginate(:page => params[:page], :per_page => 10)

    #raise @user.inspect

    @bonus_amount = Income.bonus_amount(@user,params[:month],params[:year]) if params[:month].present?
    #raise @bonus_amount.inspect
  end


  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :source, :search)
  end

end
