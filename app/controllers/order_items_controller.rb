class OrderItemsController < ApplicationController
    def index 
        @order_items = current_user.order_items.where(order_id: params[:order_id])
    end
end
