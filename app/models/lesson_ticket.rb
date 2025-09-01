class LessonTicket < ApplicationRecord
  TICKET_INFO = {
    single_lesson_pack: { price: 2000, count: 1 },
    three_lesson_pack: { price: 5000, count: 2 },
    five_lesson_pack: { price: 7500, count: 3 },
  }.freeze

  extend Enumerize

  belongs_to :user
  belongs_to :purchase

  enumerize :ticket_type, in: TICKET_INFO.keys, predicates: true

  validates :remaining_count, inclusion: { in: TICKET_INFO.values.map { it[:count] } }
  validates :price, inclusion: { in: TICKET_INFO.values.map { it[:price] } }

  before_validation :set_remaining_count
  before_validation :set_price

  private

  def set_remaining_count
    self.remaining_count = TICKET_INFO[self.ticket_type.to_sym][:count] if ticket_type.present?
  end

  def set_price
    self.price = TICKET_INFO[self.ticket_type.to_sym][:price] if ticket_type.present?
  end
end
