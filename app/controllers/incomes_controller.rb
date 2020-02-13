class IncomesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    #raise params.inspect
    @users = User.all.order('id ASC').paginate(:page => params[:page], :per_page => 10)
    @monthly_totals = Array.new(13,0)
  end

  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params)
    @income.user_id = current_user.id
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
    @income = Income.find(params[:id])
  end

  def update
    @income = Income.find(params[:id])
    @month = @income.income_date.month
    if @income.update(income_params)
      flash[:notice] = "Your Income Information has been Updated!!!"
      redirect_to show_individual_incomes_path(user_id: current_user.id, month: @month, year: params[:search])
    else
      render :edit
    end
  end

  def show
    @income = Income.find(params[:id])
  end


  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    flash[:notice] = "Your Income information has been Destroyed!!"
    redirect_back(fallback_location: incomes_path)
  end

  def approve
    @income = Income.find(params[:id])
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
    @income = Income.find(params[:id])
    @income.status = Leafe::REJECTED
    flash[:notice] = "Income has been Rejected!!!"
    @income.save
    #LeafeMailer.rejected(@leave).deliver_now
    redirect_back(fallback_location: incomes_path)
  end

  def show_individual
    #raise params[:year].inspect
    @user = User.find(params[:user_id])
    @incomes_approved = Income.search(params[:user_id], params[:month], params[:year], Income::APPROVED)
    @incomes_pending = Income.search(params[:user_id], params[:month], params[:year], Income::PENDING)
    @incomes_rejected = Income.search(params[:user_id], params[:month], params[:year], Income::REJECTED)

    @incomes_pending = @incomes_pending.paginate(:page => params[:page], :per_page => 10)
    @incomes_approved = @incomes_approved.paginate(:page => params[:page], :per_page => 10)
    @incomes_rejected = @incomes_rejected.paginate(:page => params[:page], :per_page => 10)
  end


  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :source, :search)
  end

end
