class ProductsController < ApplicationController
  before_action :set_categories

  def index
    @category = Category.all
    @category_in_id = params[:category_id]
    if params[:category_id].nil?
      @products = Product.all
    elsif params[:query].present? && params[:category_id] == ""
      @products = Product.where("name LIKE :query", query: "%#{params[:query]}%")
    elsif params[:query].present? && params[:category_id] != ""
      @products = Product.joins(:categories).where("products.name LIKE :query", query: "%#{params[:query]}%").where( categories: {id: params[:category_id].to_i})
    elsif !params[:query].present? && params[:category_id].nil?
      @products = Product.all
    elsif !params[:category_id].nil? && params[:query].nil?
      @products = Category.find_by(id: params[:category_id]).products
    elsif params[:query] == "" &&  params[:category_id] == ""
      @products = Product.all
    elsif params[:query] == "" &&  !params[:category_id].nil?
      @products = Category.find_by(id: params[:category_id]).products
    else  
      @products = Product.all
    end
  end

  def new 
    @product = Product.new
  end

  def create
    # authorize current_user
    @product = current_user.products.create(name: product_params[:name], description: product_params[:description], price: product_params[:price]);
    product_params[:categories_ids].each do |category_id|
      if category_id != ""
        ProductCategory.create(product_id: @product.id, category_id: category_id )
      end
    end
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

  def delete_product 
    @product = Product.find_by(id: params[:id]);
    @product.destroy
  end

  private 
    def product_params 
      params.require(:product).permit(:name, :description, :price, categories_ids: [])
    end
  
    def set_categories 
      @categories = Category.all.order(:name)
    end
end
