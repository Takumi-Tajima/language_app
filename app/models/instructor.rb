class Instructor < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :trackable, :confirmable

  attribute :introduction, :text, default: 'プロフィール準備中'

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :name, presence: true
  validates :introduction, presence: true

  scope :default_order, -> { order(:id) }
end
