class IncomesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    #raise params.inspect
    @users = User.all.order('id ASC').paginate(:page => params[:page], :per_page => 3)
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
    if @income.update(income_params)
      flash[:notice] = "Your Income Information has been Updated!!!"
      redirect_back(fallback_location: incomes_path)
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
      flash[:notice] = "The Income information has been changed successfully"
    else
      @income.status = Leafe::APPROVED
      @income.approve_time = @income.updated_at
      #LeafeMailer.approved(@leave).deliver_now
      #raise @allocated_leave.inspect
      flash[:notice] = "Leafe has been approved successfully"
    end
    @income.save
    redirect_back(fallback_location: incomes_path)
  end

  def reject
    @income = Income.find(params[:id])
    @income.status = Leafe::REJECTED
    flash[:notice] = "The Leafe information has been changed successfully"
    @income.save
    #LeafeMailer.rejected(@leave).deliver_now
    redirect_back(fallback_location: incomes_path)
  end

  def show_individual
    #raise params.inspect
    if params[:search]
      if params[:user_id] and params[:month].nil?
        @user = User.find(params[:user_id])
        @incomes_pending = Income.where(status: 'Pending', user_id: params[:user_id]).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
        @incomes_approved = Income.where(status: 'Approved', user_id: params[:user_id]).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
        @incomes_rejected = Income.where(status: 'Rejected', user_id: params[:user_id]).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
      elsif params[:user_id] and params[:month]
        @user = User.find(params[:user_id])
        @incomes_pending = Income.where(status: 'Pending', user_id: params[:user_id]).where('extract(month from income_date) = ?', params[:month]).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
        @incomes_approved = Income.where(status: 'Approved', user_id: params[:user_id]).where('extract(month from income_date) = ?', params[:month]).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
        @incomes_rejected = Income.where(status: 'Rejected', user_id: params[:user_id]).where('extract(month from income_date) = ?', params[:month]).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
      else
        @user = User.find(current_user.id)
        @incomes_pending = Income.where(status: 'Pending', user_id: current_user.id).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
        @incomes_approved = Income.where(status: 'Approved', user_id: current_user.id).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
        @incomes_rejected = Income.where(status: 'Rejected', user_id: current_user.id).where('extract(year from income_date) = ?', params[:search]).order('id ASC')
      end
    else
      if params[:user_id] and params[:month].nil?
        @user = User.find(params[:user_id])
        @incomes_pending = Income.where(status: 'Pending', user_id: params[:user_id]).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
        @incomes_approved = Income.where(status: 'Approved', user_id: params[:user_id]).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
        @incomes_rejected = Income.where(status: 'Rejected', user_id: params[:user_id]).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
      elsif params[:user_id] and params[:month]
        @user = User.find(params[:user_id])
        @incomes_pending = Income.where(status: 'Pending', user_id: params[:user_id]).where('extract(month from income_date) = ?', params[:month]).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
        @incomes_approved = Income.where(status: 'Approved', user_id: params[:user_id]).where('extract(month from income_date) = ?', params[:month]).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
        @incomes_rejected = Income.where(status: 'Rejected', user_id: params[:user_id]).where('extract(month from income_date) = ?', params[:month]).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
      else
        @user = User.find(current_user.id)
        @incomes_pending = Income.where(status: 'Pending', user_id: current_user.id).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
        @incomes_approved = Income.where(status: 'Approved', user_id: current_user.id).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
        @incomes_rejected = Income.where(status: 'Rejected', user_id: current_user.id).where('extract(year from income_date) = ?', Date.today.year).order('id ASC')
      end
    end

    @incomes_pending = @incomes_pending.paginate(:page => params[:page], :per_page => 10)
    @incomes_approved = @incomes_approved.paginate(:page => params[:page], :per_page => 10)
    @incomes_rejected = @incomes_rejected.paginate(:page => params[:page], :per_page => 10)
  end


  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :search)
  end

end
