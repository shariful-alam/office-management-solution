class IncomesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users_income = User.paginate(:page => params[:users_incomes], :per_page => 20)
    @users_bonus = @users_income.paginate(:page => params[:users_bonuses], :per_page => 20)

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
      if current_user.admin? or current_user.super_admin?
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
    if @income && @income.destroy
    flash[:notice] = 'Your Income information has been destroyed'
    redirect_back(fallback_location: incomes_path)
    else
      flash[:alert] = 'Income could not be deleted!!'
      render :index
    end
  end

  def approve
    if @income.approved?
      @income.approve_time = nil
      @income.pending!
      flash[:notice] = 'The income status has been changed successfully'
    else
      @income.approve_time = DateTime.now
      @income.approved!
      flash[:notice] = 'Income has been approved'
    end
    redirect_back(fallback_location: incomes_path)
  end

  def reject
    @income.rejected!
    flash[:notice] = 'Income has been rejected'
    redirect_back(fallback_location: incomes_path)
  end

  def show_individual
    #TODO: Replace this code with cancan
    if current_user.admin? or current_user.super_admin?
      @user =  User.find(params[:user_id])
    else
      flash[:alert] = "Access Denied" if params[:user_id].to_i != current_user.id
      @user = current_user
    end

    @incomes = @user.incomes
    #used pg specific query to reduce complexity
    @incomes = @incomes.find_in_income_date_by('month', params[:month]) if params[:month].present?
    @incomes = @incomes.find_in_income_date_by('year', params[:year].present? ? params[:year] : Date.today.year)

    @incomes_approved = @incomes.approved.paginate(:page => params[:approved_incomes], :per_page => 20)
    @incomes_pending = @incomes.pending.paginate(:page => params[:pending_incomes], :per_page => 20)
    @incomes_rejected = @incomes.rejected.paginate(:page => params[:rejected_incomes], :per_page => 20)

    @bonus_amount = Income.bonus_amount(@user,params[:month],params[:year]) if params[:month].present?
  end

  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :source, :search)
  end

end
