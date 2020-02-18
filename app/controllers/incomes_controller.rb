class IncomesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all.order('id ASC').paginate(:page => params[:page], :per_page => 10)
    @monthly_totals = Array.new(13,0)
    @all_incomes = Array.new(15){Array.new(15) { 0 } }
    @all_bonuses = Array.new(15){Array.new(15) { 0 } }
    @total_income_per_user = Array.new

    @users.each do |user|
      Income::MONTHS.each do |month|
        income = Income.find_incomes_by_months(user,month,params[:search])
        @all_incomes[user.id][month] = income
        @all_bonuses[user.id][month] = Income.bonus_amount(user.id,month,params[:search])
        #raise @all_incomes[user.id][month].inspect
      end
      @total_income_per_user[user.id] = Income.find_total(user,params[:search])
    end
    #raise @all_bonuses.inspect
  end

  def new

  end

  def create
    @income = current_user.incomes.new(income_params)
    if @income.save
      flash[:notice] = "Your Income has been Queued for Pending!!"
      if current_user.role == User::ADMIN or current_user.role == User::SUPER_ADMIN
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
    @month = @income.income_date.month
    if @income.update(income_params)
      flash[:notice] = "Your Income Information has been Updated!!!"
      redirect_to show_individual_incomes_path(user_id: current_user.id, month: @month, year: params[:search])
    else
      render :edit
    end
  end

  def show

  end


  def destroy
    @income.destroy
    flash[:notice] = "Your Income information has been Destroyed!!"
    redirect_back(fallback_location: incomes_path)
  end

  def approve
    if @income.status == Leafe::APPROVED
      @income.status = Leafe::PENDING
      flash[:notice] = "The Income Information has been Changed Successfully!!!"
    else
      @income.status = Leafe::APPROVED
      @income.approve_time = @income.updated_at
      #LeafeMailer.approved(@leave).deliver_now
      #raise @allocated_leave.inspect
      flash[:notice] = "Income has been Approved!!!"
    end
    @income.save
    redirect_back(fallback_location: incomes_path)
  end

  def reject
    @income.status = Leafe::REJECTED
    flash[:notice] = "Income has been Rejected!!!"
    @income.save
    #LeafeMailer.rejected(@leave).deliver_now
    redirect_back(fallback_location: incomes_path)
  end

  def show_individual
    @incomes = Income.joins(:user)
    @incomes = @incomes.where('extract(month from income_date) = ?', params[:month]) if params[:month].present?
    @incomes = @incomes.where('extract(year from income_date) = ?', params[:year].present? ? params[:year] : Date.today.year) if params[:year].present?

    @incomes_approved = @incomes.with_status(Income::APPROVED).paginate(:page => params[:page], :per_page => 10)
    @incomes_pending = @incomes.with_status(Income::PENDING).paginate(:page => params[:page], :per_page => 10)
    @incomes_rejected = @incomes.with_status(Income::REJECTED).paginate(:page => params[:page], :per_page => 10)

    @bonus_amount = Income.bonus_amount(params[:user_id],params[:month],params[:year]) if params[:month].present?
    #raise @bonus_amount.inspect
  end


  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :source, :search)
  end

end
