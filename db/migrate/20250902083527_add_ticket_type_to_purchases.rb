class AddTicketTypeToPurchases < ActiveRecord::Migration[8.0]
  def change
    add_column :purchases, :ticket_type, :string, null: false
  end
end
