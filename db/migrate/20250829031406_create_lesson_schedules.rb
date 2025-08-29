class CreateLessonSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_schedules do |t|
      t.references :lesson, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :meeting_url, null: false
      t.boolean :is_booked, null: false, default: false

      t.timestamps
    end
  end
end
