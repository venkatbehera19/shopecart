class CheckoutController < ApplicationController
  before_action :logged_in_user

  def show 
    order = Order.find(params[:order_details])
    generated_line_items = []
    order.order_items.each do |order_item|
      line_item = {
        price_data: {
          currency: 'inr',
          product_data: {
          }
        },
      }
      line_item[:quantity] = order_item.quantity
      line_item[:price_data][:unit_amount] = order_item.product_price.to_i * 100
      line_item[:price_data][:product_data][:name] = order_item.product_name
      line_item[:price_data][:product_data][:description] = order_item.product_price
      generated_line_items << line_item
    end
    @checkout_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: generated_line_items,
      mode: 'payment',
      success_url: "http://localhost:3000/checkout/success?session_id={CHECKOUT_SESSION_ID}&order_id=#{order.id}"
    )
  end

  def success 
    Order.find(params[:order_id]).update_attribute(:paid, true)
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
  end

  private
    def logged_in_user 
      unless log_in?
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end
end
