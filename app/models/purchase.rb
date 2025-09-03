class Purchase < ApplicationRecord
  include Payable

  belongs_to :user

  validates :total_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tax_amount, presence: true, numericality: { only_integer: true }
  validates :subtotal, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :ticket_type, inclusion: { in: LessonTicket::TICKET_TYPES }
end
