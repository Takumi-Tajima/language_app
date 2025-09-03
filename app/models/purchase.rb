class Purchase < ApplicationRecord
  extend Enumerize

  include Payable

  belongs_to :user

  enumerize :ticket_type, in: LessonTicket::TICKET_TYPES, predicates: true

  validates :total_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tax_amount, presence: true, numericality: { only_integer: true }
  validates :subtotal, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(created_at: :desc) }
end
