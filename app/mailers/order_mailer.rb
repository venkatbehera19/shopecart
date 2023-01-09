class OrderMailer < ApplicationMailer
  default from: 'shopecart@gmail.com'

  def ordered_details 
    current_user = params[:user]
    @total_amount = params[:total_amount]
    @order_details = params[:order_details]
    attachments['order.pdf'] = generate_pdf_content(@order_details)
    mail(to: current_user.email, subject: 'Order placed')
  end

  private 
    def generate_pdf_content(order_details)
      pdf = Prawn::Document.new 
      pdf.text "Hello World"
      pdf.text "#{order_details.total_amount}"
      # table_data = [["this is the first row"], ["second row"]]
      # pdf.table(table_data, :width => 500)
      Tempfile.create do |f|
        pdf.render_file f 
        f.flush 
        File.read(f)
      end
    end

end
