class UpdateOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :invoice_number
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
