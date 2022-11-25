class RemoveFieldNameFromOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :invoice_number, :string
  end
end
