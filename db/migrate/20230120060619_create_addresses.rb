class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :pincode
      t.text :address
      t.boolean :is_default, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
