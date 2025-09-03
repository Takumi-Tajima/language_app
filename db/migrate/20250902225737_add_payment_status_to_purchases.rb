class AddPaymentStatusToPurchases < ActiveRecord::Migration[8.0]
  def change
    remove_column :purchases, :purchased_at, :datetime
    add_column :purchases, :paid_at, :datetime
  end
end
