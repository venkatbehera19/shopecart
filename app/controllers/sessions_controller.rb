class SessionsController < ApplicationController

  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    user = User.find_by(email: email.downcase)
    respond_to do |format|
      if user&.authenticate(password)
        log_in user
        format.html { redirect_to root_path, :flash => { :success => "Login Successfull." } }
      else
        format.html { redirect_to login_path, :flash => { :danger => "Invalid email/password." } }
      end
    end
  end

  def destroy 
    puts "Called"
    log_out
    redirect_to root_url
  end

end
