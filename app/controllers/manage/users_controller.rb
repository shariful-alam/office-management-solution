class Manage::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # before_action :check, only: [:destory, :new, :create, :edit]
  #
  # def check
  #   if current_user.role != User::ADMIN
  #     @user = User.find(params[:id])
  #     if @user.id != current_user.id
  #       redirect_to manage_users_path, notice: "Access Denied"
  #     end
  #   end
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to manage_users_path, notice: "User has been created successfully"
    else
      render 'new'
    end
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).order('users.id ASC').paginate(:page => params[:page], :per_page => 2)
    else
      @users = User.order('users.id ASC').paginate(:page => params[:page], :per_page => 2)
    end
    #raise @users.to_sql
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to manage_users_path, notice: "User has been removed successfully"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to manage_user_path, notice: "User data has been updated successfully"
    else
      render 'edit'
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :role, :password, :password_confirmation, :image_file_name, :image, :image_content_type, :image_file_size, :image_updated_at, :remove_image)
  end


end
