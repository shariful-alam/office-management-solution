class Api::CategoriesController < Api::ApiController

  before_action :authenticate_user_from_token
  load_and_authorize_resource

  def index
    @categories = @categories.paginate(:page => params[:page], :per_page => Budget::PER_PAGE)
  end

  def create
    if @category && @category.save
      render json: {message: "Category for Budget has been created successfully!!", url: api_category_url(@category, format: :json)}, status: :created
    else
      render json: @category.errors, status: 422
    end
  end

  def show

  end

  def edit

  end

  def update
    if @category && @category.update(category_params)
      render json: {message: "Category for Budget has been updated successfully!!", url: api_category_url(@category, format: :json)}, status: :created
    else
      render json: @category.errors, status: 422
    end
  end

  def destroy
    if @category && @category.destroy
      render json: {message: "Category for Budget has been removed successfully!!"}, status: :ok
    else
      render json: {error: "Category for Budget could not be deleted!!"}, status: 422
    end
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end


end
