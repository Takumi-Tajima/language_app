class Lesson < ApplicationRecord
  extend Enumerize

  belongs_to :instructor

  enumerize :language, in: Language::LANGUAGES, predicates: true

  validates :language, presence: true
  validates :name, presence: true
  validates :description, presence: true
end
