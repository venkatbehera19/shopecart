class CartItemsController < ApplicationController
  # before_action :log_in? 
  def index 
    if log_in?
      @cart_items = current_user.cart_items.order(:created_at)
    end
  end

  def create
    if log_in?
      @check_item = current_user.cart.cart_items.find_by(product_id: params[:product_id])
      respond_to do |format|
        format.turbo_stream do 
          if @check_item.nil?
            @new_cart_item = current_user.cart.cart_items.build(product_id: params[:product_id], quantity:1)
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
    else
      new_product = { 
        :id => params[:product_id], 
        :quantity => 1, 
        :name => params[:name], 
        :description => params[:description], 
        :price => params[:price]
       }
      respond_to do |format| 
        format.turbo_stream do
          add_cart_to_sessions(new_product);
          render turbo_stream: [
              turbo_stream.update('cart', partial: '/layouts/cart', locals: { count: cart_sessions.length})
          ]
        end
      end
    end
  end

  def update
    if log_in?
      @cart = CartItem.find_by(id: params[:id]);
      @cart.update_attribute(:quantity, params[:quantity]);
      @cart_items = current_user.cart_items.order(:created_at)
      respond_to do |format|
        if @cart
          format.js
        end
      end
    else
      updated_product_details = { 
        :id => params[:product_id], 
        :quantity => params[:quantity], 
        :price => params[:price] 
      }
      @cart_items = update_session_element(updated_product_details);
      @cart = get_session_element(params[:id])
      respond_to do |format|
        if @cart
          format.js
        end
      end
    end
  end

  def destroy 
    if log_in?
      @check_item = current_user.cart.cart_items.find_by(id: params[:id])
      @cart_items = current_user.cart_items.order(:created_at)
      respond_to do |format|
        if @check_item.destroy
          format.html { redirect_to cart_items_path, :flash => { :success => "Item removed from the cart." } }
          format.js
        end
      end
    else  
      @check_item = get_session_element(params[:id])
      @cart_items = remove_session_element(params[:id])
      respond_to do |format|
        format.js
      end
    end
  end
  
end
