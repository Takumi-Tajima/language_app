class Purchase < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :ticket_type, in: LessonTicket::TICKET_TYPES, predicates: true

  validates :total_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tax_amount, presence: true, numericality: { only_integer: true }
  validates :subtotal, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(created_at: :desc) }
  scope :paid, -> { where.not(paid_at: nil) }
  scope :unpaid, -> { where(paid_at: nil) }

  def paid!
    update!(paid_at: Time.current)
  end

  def unpaid!
    update!(paid_at: nil)
  end

  def paid?
    paid_at.present?
  end
end
