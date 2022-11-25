class CartItemsController < ApplicationController
    before_action :logged_in_user , only: [:create, :destory, :update]

    def index 
        @all_cart_items = [];
        cart_items = current_user.cart_items
        cart_items.each do |item|
            modifed_cart_items = {}
            modifed_cart_items["id"] = item.id;
            modifed_cart_items["product_id"] = item.product_id;
            modifed_cart_items["cart_id"] = item.cart_id;
            modifed_cart_items["quantity"] = item.quantity;
            product_detail = current_user.cart_products.find_by(id:item.product_id);
            modifed_cart_items["product_name"] = product_detail.name
            modifed_cart_items["product_price"] = product_detail.price
            modifed_cart_items["product_description"] = product_detail.description
            @all_cart_items << modifed_cart_items
        end
    end

    def create
        @check_item = current_user.cart.cart_items.find_by(product_id: params[:product])
        @new_cart_item = current_user.cart.cart_items.build(product_id: params[:product], quantity:1)
        if @check_item.nil?
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

    def checkout 
        puts "Calling Checkout -- #{params}"
    end

    private 
        def logged_in_user 
            unless log_in?
                flash[:danger] = "please log in"
                redirect_to login_url
            end
        end
end
