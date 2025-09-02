class AddPaymentStatusToPurchases < ActiveRecord::Migration[8.0]
  def change
    add_column :purchases, :is_paid, :boolean, default: false, null: false
  end
end
