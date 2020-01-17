class Manage::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check, only: [:destory, :new, :create]

  def check
    if current_user.role!=User::ADMIN
      redirect_to manage_users_path
    end
  end

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to manage_users_path
    else
      render 'new'
    end
  end

  def index
    @users = User.order('users.id ASC').all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to manage_users_path
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id and current_user.role!=User::ADMIN
      redirect_to manage_users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to manage_user_path
    else
      render 'edit'
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :role, :password,:password_confirmation)
  end


end
