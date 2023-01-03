class OrderMailer < ApplicationMailer
  default from: 'shopecart@gmail.com'

  def ordered_details 
    current_user = params[:user]
    @total_amount = params[:total_amount]
    mail(to: current_user.email, subject: 'Order placed')
  end
  
end
