class StaticPagesController < ApplicationController
  def home
    @products = Product.all.paginate(page: params[:page], per_page: 10)
  end
end
