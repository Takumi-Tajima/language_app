class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :lesson_schedule, null: false, foreign_key: true
      t.references :lesson_ticket, null: false, foreign_key: true

      t.timestamps
      t.index %i[user_id lesson_schedule_id], unique: true
    end
  end
end
