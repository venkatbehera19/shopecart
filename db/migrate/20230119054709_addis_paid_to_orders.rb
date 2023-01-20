class AddisPaidToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :paid, :boolean, :default => false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
