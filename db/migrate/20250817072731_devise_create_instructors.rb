# frozen_string_literal: true

class DeviseCreateInstructors < ActiveRecord::Migration[8.0]
  def change
    create_table :instructors do |t|
      ## Database authenticatable
      t.string :name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.text :introduction, null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at

      t.timestamps null: false
    end

    add_index :instructors, :email,                unique: true
    add_index :instructors, :reset_password_token, unique: true
    add_index :instructors, :confirmation_token,   unique: true
  end
end
