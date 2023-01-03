# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email 
    @user = User.last
    @url = 'http://localhost:3000/login'
    mail to: @user.email, subject: 'welcome to My Awesome Site'
  end
end
