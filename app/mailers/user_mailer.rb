class UserMailer < ApplicationMailer
  default from: 'shopecart@gmail.com'

  def welcome_email 
    @user = params[:user]
    @url = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'welcome to My Awesome Site')
  end
  
end
