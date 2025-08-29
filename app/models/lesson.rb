class Lesson < ApplicationRecord
  extend Enumerize

  belongs_to :instructor
  has_many :lesson_schedules, dependent: :destroy

  enumerize :language, in: Language::LANGUAGES, predicates: true

  validates :language, presence: true
  validates :name, presence: true
  validates :description, presence: true

  scope :default_order, -> { order(id: :desc) }
end
