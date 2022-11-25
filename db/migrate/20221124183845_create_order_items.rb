class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.float :total_amount
      t.string :invoice_number
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :product_name
      t.string :product_description
      t.float :product_price

      t.timestamps
    end
  end
end
