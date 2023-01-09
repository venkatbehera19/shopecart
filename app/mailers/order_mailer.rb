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
      doc = PrawnRails::Document.new(page_layout: :landscape)
      table_data = Array.new 
      table_data << ["Name", "Product Price", "Total Amount"]
      doc.table(table_data, :width => 500, :cell_style => { inline_format: true })
      doc.table order_details.order_items.collect{|p| [p.product_name, p.product_price,  p.total_amount ]}, width: 500, cell_style: { inline_format: true }
      doc.text "All Total - #{order_details.total_amount}"
      Tempfile.create do |f|
        doc.render_file f 
        f.flush 
        File.read(f)
      end
    end

end
