class CreateLessonTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :purchase, null: false, foreign_key: true
      t.string :ticket_type, null: false
      t.integer :remaining_count, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
