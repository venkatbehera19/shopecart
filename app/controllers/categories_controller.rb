class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index  
    @categories = Category.all
  end

  def new 
    @category = Category.new
  end

  def create 
    @category = Category.new(category_params);
    respond_to do |format| 
      if @category.save 
        format.js
      else  
        format.js
        # format.html { status: :unprocessable_entity }
      end
    end
  end

  def destroy 
    @category = Category.all.find_by(id: params[:id]);
    @category.destroy
    respond_to do |format| 
      format.js
    end
  end

  def edit 
    @category = Category.find_by(id: params[:id])
  end

  def update 
    @category = Category.find_by(id: params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.js
      end
    end
  end

  private
    def logged_in_user
      unless is_admin?
        flash[:danger] = "Restricted for you."
        redirect_to root_url
      end
    end

    def category_params 
      params.require(:category).permit(:name)
    end
end
