class AddInvoiceToOrders < ActiveRecord::Migration[7.0]
  def change
    # add_column :orders, :invoice_id, :references
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_reference :orders, :invoice, foreign_key: true
  end
end
