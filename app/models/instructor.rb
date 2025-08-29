class Instructor < ApplicationRecord
  extend Enumerize

  has_many :lessons, dependent: :destroy

  enumerize :teachable_language, in: Language::LANGUAGES, predicates: true, multiple: true

  devise :database_authenticatable, :rememberable, :validatable, :trackable, :confirmable

  attribute :introduction, :text, default: 'プロフィール準備中'
  attribute :teachable_language, :string, array: true, default: -> { [:japanese] }

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :name, presence: true
  validates :introduction, presence: true

  scope :default_order, -> { order(:id) }
end
