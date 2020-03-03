class BudgetCategoriesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @budgets_categories = @budget_categories.paginate(:page => params[:page], :per_page => Budget::PER_PAGE)
  end

  def new

  end

  def create
    if @budget_category.save
      redirect_to budget_categories_path, notice: 'Category for Budget has been created successfully!!'
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    if @budget_category.update(budget_category_params)
      redirect_to budget_categories_path, notice: 'Category for Budget has been updated successfully!!'
    else
      render :edit
    end
  end

  def destroy
    if @budget_category && @budget_category.destroy
      flash[:alert] = 'Category for Budget has been removed successfully!!'
    else
      flash[:alert] = 'Category for Budget could not be deleted!!'
    end
    redirect_back(fallback_location: budget_categories_path)
  end


  private
  def budget_category_params
    params.require(:budget_category).permit( :category_name)
  end


end
