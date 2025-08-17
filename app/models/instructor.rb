class Instructor < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable, :confirmable

  validates :name, presence: true
  validates :introduction, presence: true
end
