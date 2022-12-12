class ProductsController < ApplicationController
  before_action :set_categories

  def index
    @category = Category.all
    if params[:query].present?
      @products = Product.where("name LIKE :query", query: "%#{params[:query]}%")
    else 
      @products = Product.all
    end
  end

  def new 
    @product = Product.new
  end

  def create
    @product = current_user.products.create(product_params);
    respond_to do |format|
      if @product 
        format.js;
      else 
        format.js 
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def destroy 
    @deleted_product = current_user.products.find_by(id: params[:id]);
    @deleted_product.destroy 
    respond_to do |format|
      format.js
    end
  end

  private 
    def product_params 
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
  
    def set_categories 
      @categories = Category.all.order(:name)
    end
end
