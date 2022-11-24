class CartItemsController < ApplicationController
    before_action :logged_in_user , only: [:create, :destory, :update]
    def index 
        @all_cart_items = [];
        @cart_items = current_user.cart.cart_items.all;
        @cart_items.each do |item|
            modifed_product = Hash.new
            prod = Product.find_by(id: item.product_id)
            modifed_product[:product] = prod
            modifed_product[:item] = item
            @all_cart_items << modifed_product
        end
        # @cart_items = current_user.cart.cart_items.all
    end
    def create
        @check_item = current_user.cart.cart_items.find_by(product_id: params[:product])
        @new_cart_item = current_user.cart.cart_items.build(product_id: params[:product], quantity:1)
        if @check_item.nil?
            # puts "Present"
            if @new_cart_item.save
                flash[:success] = "Item added in the cart."
                redirect_to root_path
            else  
                redirect_to root_path
                flash[:danger] = "Something went wrong."
            end
        else
            redirect_to root_path
            flash[:info] = "Item is already present in the cart. please go to Cart!."
        end
    end
    def update
        # check_item = current_user.cart.cart_items.find_by(id: params[:id])
        # puts "ADD HHH"
        # puts "#{params}"
        # puts "#{check_item}"
        if CartItem.where(id:params[:id]).first.update_attribute(:quantity, params[:quantity]);
            flash[:success] = "Item updated in the cart."
            redirect_to cart_items_path
        end
    end
    def destroy 
        puts "Called, #{params}"
        check_item = current_user.cart.cart_items.find_by(id: params[:id])
        if check_item.destroy
            flash[:success] = "Item removed from the cart."
            redirect_to cart_items_path
        end
    end
    private 
        def logged_in_user 
            unless log_in?
                flash[:danger] = "please log in"
                redirect_to login_url
            end
        end
end
