class ProductsController < ApplicationController

  def index
    if params[:query].present?
      @products = Product.where("name LIKE :query", query: "%#{params[:query]}%")
    else 
      @products = Product.all
    end
  end
  
end
