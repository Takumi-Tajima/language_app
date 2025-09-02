class AddPaymentStatusToPurchases < ActiveRecord::Migration[8.0]
  def change
    add_column :purchases, :paid_at, :datetime
  end
end
