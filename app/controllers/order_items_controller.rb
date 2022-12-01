class OrderItemsController < ApplicationController
    before_action :logged_in_user

    def index 
        @order_items = current_user.order_items.where(order_id: params[:order_id])
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
