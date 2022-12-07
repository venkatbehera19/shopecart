class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    isEmail = email.empty?
    isPassword = password.empty?
    @user = User.find_by(email: email.downcase)
    respond_to do |format|
      if !isEmail && !isPassword
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
          end
          cart_sessions_clear
          format.html { redirect_to root_path, :flash => { :success => "Login Successfull." } }
        else
          format.js
          format.html { redirect_to login_path, :flash => { :danger => "Invalid Username & Password. " }}
        end
      else
        format.turbo_stream do
          if isPassword && isEmail
            render turbo_stream: [
              turbo_stream.update('error', partial: '/sessions/error_inline_email', locals: {error_message: "Email can not be empty."}),
              turbo_stream.update('password_error', partial: '/sessions/error_inline_password', locals: {error_message: "Password can not be empty."})
            ]
          elsif isEmail 
            render turbo_stream: [
              turbo_stream.update('error', partial: '/sessions/error_inline_email', locals: {error_message: "Email can not be empty."})
            ]
          elsif isPassword
            render turbo_stream: [
              turbo_stream.update('password_error', partial: '/sessions/error_inline_password', locals: {error_message: "Password can not be empty."}),
              turbo_stream.update('error', partial: '/sessions/error_inline_email', locals: {error_message: ""})
            ]
          end
        end
      end
    end
  end

  def destroy 
    log_out
    redirect_to root_url
  end

end
