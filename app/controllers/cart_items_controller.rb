class CartItemsController < ApplicationController
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
      respond_to do |format| 
        format.turbo_stream do
          add_cart_to_sessions(add_to_cart_params);
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
      @cart.update_attribute(:quantity, params[:quantity])
      @cart_items = current_user.cart_items.order(:created_at)
      respond_to do |format|
        if @cart
          format.js
        end
      end
    else
      @cart_items = update_session_element(update_cart_params)
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

  private 
    def add_to_cart_params 
      params
        .permit(:id, :name, :description, :price)
        .merge(quantity: 1)
    end

    def update_cart_params 
      params.permit(:id, :quantity, :price)
    end
end
