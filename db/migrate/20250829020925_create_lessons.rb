class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :instructor, null: false, foreign_key: true
      t.string :language, null: false
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
