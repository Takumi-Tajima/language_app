class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :purchases, dependent: :destroy
  has_many :lesson_tickets, dependent: :destroy
end
