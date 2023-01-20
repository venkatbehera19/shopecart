class OrdersController < ApplicationController
  before_action :logged_in_user
  include CartItemsHelper
  
  def index 
    if is_admin?
      @orders = Order.all 
    else  
      @orders = current_user.orders
    end
  end

  def create 
    invoice = Invoice.create(user_id: current_user.id, invoice_date: Time.now)
    cart_items = current_user.cart_items
    new_record = current_user.orders.create(total_amount: cart_total_money(cart_items), invoice_id: invoice.id)
    if new_record 
      cart_items.each do |cart_item|
        new_record.order_items.create(
          product_id: cart_item.product.id, 
          product_name: cart_item.product.name,
          product_description: cart_item.product.description,
          product_price: cart_item.product.price,
          quantity: cart_item.quantity,
          total_amount: cart_item.quantity * cart_item.product.price
        )
      end
      OrderMailer.with(user: current_user, order_details: new_record).ordered_details.deliver_now
      redirect_to checkout_path(:order_details => new_record)
      current_user.cart_items.each do |cart_item|
        cart_item.destroy
      end
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
