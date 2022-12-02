class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    @user = User.find_by(email: email.downcase)
    respond_to do |format|
      if @user&.authenticate(password)
        format.js 
        log_in @user
        if is_cart_sessions?
          user_cart = @user.cart.cart_items
          cart_sessions.each do |item|
            if is_session_cart_present_in_user_cart(user_cart, item) == nil 
              @user.cart.cart_items.create(product_id: item["id"], quantity:1)
            end
          end
          # cart_sessions.
        end
        cart_sessions_clear
        format.html { redirect_to root_path, :flash => { :success => "Login Successfull." } }
      else
        # binding.break
        format.js
        format.html { redirect_to login_path, :flash => { :danger => "Invalid Username & Password. " }}
      end
    end
  end

  def destroy 
    puts "Called"
    log_out
    redirect_to root_url
  end

end
