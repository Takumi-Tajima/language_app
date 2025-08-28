class AddTeachableLanguageToInstructors < ActiveRecord::Migration[8.0]
  def change
    add_column :instructors, :teachable_language, :string, null: false
  end
end
