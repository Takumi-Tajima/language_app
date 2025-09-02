class Purchase < ApplicationRecord
  belongs_to :user

  validates :ticket_type, inclusion: { in: LessonTicket::TICKET_INFO.keys.map(&:to_s) }
  validates :purchased_at, presence: true
  validates :total_amount, numericality: { only_integer: true }
  validates :tax_amount, numericality: { only_integer: true }
  validates :subtotal, numericality: { only_integer: true }

  after_create :create_lesson_ticket!

  private

  def create_lesson_ticket!
    LessonTicket.create!(
      user: self.user,
      purchase: self,
      ticket_type: self.ticket_type,
      remaining_count: LessonTicket::TICKET_INFO[self.ticket_type.to_sym][:lesson_count],
      price: self.subtotal
    )
  end
end
