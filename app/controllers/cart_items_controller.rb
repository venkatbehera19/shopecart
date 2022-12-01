class CartItemsController < ApplicationController
    before_action :logged_in_user

    def index 
        @cart_items = current_user.cart_items.order(:created_at)
    end

    def create
        @check_item = current_user.cart.cart_items.find_by(product_id: params[:product])
        @new_cart_item = current_user.cart.cart_items.build(product_id: params[:product], quantity:1)
        respond_to do |format|
            format.turbo_stream do 
                # binding.break
                if @check_item.nil?
                    if @new_cart_item.save
                        flash.now[:success] = "Item added in the cart."
                        render turbo_stream: [
                                              turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash }),
                                              turbo_stream.update('cart', partial: '/layouts/cart', locals: { count: total_cart_items})
                                              ]                      
                    end
                else
                    flash.now[:danger] = "Item is already present in the cart. please go to Cart!."
                    render turbo_stream: [ turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash }) ]
                end
            end
        end
    end

    def update
        cart = CartItem.find_by(id: params[:id]);
        cart.update_attribute(:quantity, params[:quantity]);
        @cart_item = CartItem.find_by(id: params[:id]);
        @cart_items = current_user.cart_items.order(:created_at)
        respond_to do |format|
            if cart
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
                format.js
            end
        end
    end

    def checkout 
    end

    private 
        def logged_in_user 
            unless log_in?
                flash[:danger] = "please log in"
                redirect_to login_url
            end
        end
end
