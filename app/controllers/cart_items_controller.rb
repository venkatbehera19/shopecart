class CartItemsController < ApplicationController
    before_action :logged_in_user

    def index 
        @cart_items = current_user.cart_items.order(:created_at)
    end

    def create
        @check_item = current_user.cart.cart_items.find_by(product_id: params[:product])
        @new_cart_item = current_user.cart.cart_items.build(product_id: params[:product], quantity:1)
        if @check_item.nil?
            if @new_cart_item.save
                flash[:success] = "Item added in the cart."
                # redirect_to root_path
                render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash })
            else  
                redirect_to root_path
                flash[:danger] = "Something went wrong."
            end
        else
            # redirect_to root_path
            flash[:info] = "Item is already present in the cart. please go to Cart!."
            render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash })
        end
    end

    def update
        cart = CartItem.find_by(id: params[:id]);
        cart.update_attribute(:quantity, params[:quantity]);
        @cart_item = CartItem.find_by(id: params[:id]);
        @cart_items = current_user.cart_items.order(:created_at)
        respond_to do |format|
            if cart
                # flash[:success] = "Item updated in the cart."
                # redirect_to cart_items_path
                # render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash })
                # render turbo_stream: turbo_stream.update('cart_items', partial: 'cart_items/items')
                format.js
            end
        end
    end

    def destroy 
        @check_item = current_user.cart.cart_items.find_by(id: params[:id])
        @cart_items = current_user.cart_items.order(:created_at)
        respond_to do |format|
            if @check_item.destroy
                format.html { redirect_to cart_items_path, :flash => { :success => "Item removed from the cart." } }
                # flash[:success] = "Item removed from the cart."
                # render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash })
                # redirect_to cart_items_path
                format.js
            end
        end
    end

    def checkout 
        puts "Calling Checkout -- #{params}"
    end

    private 
        def logged_in_user 
            puts "Called"
            unless log_in?
                flash[:danger] = "please log in"
                redirect_to login_url
            end
        end
end
