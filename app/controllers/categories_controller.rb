class CategoriesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @categories = @categories.paginate(:page => params[:page], :per_page => Budget::PER_PAGE)
  end

  def new

  end

  def create
    if @category.save
      redirect_to categories_path, notice: 'Category for Budget has been created successfully!!'
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category for Budget has been updated successfully!!'
    else
      render :edit
    end
  end

  def destroy
    if @category && @category.destroy
      flash[:alert] = 'Category for Budget has been removed successfully!!'
    else
      flash[:alert] = 'Category for Budget could not be deleted!!'
    end
    redirect_back(fallback_location: categories_path)
  end


  private
  def category_params
    params.require(:category).permit(:category_name)
  end


end
