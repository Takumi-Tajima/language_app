class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :purchased_at, null: false
      t.integer :total_amount, null: false
      t.integer :tax_amount, null: false
      t.integer :subtotal, null: false

      t.timestamps
    end
  end
end
