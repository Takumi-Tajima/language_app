class Purchase < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :ticket_type, in: LessonTicket::TICKET_TYPES, predicates: true

  validates :total_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tax_amount, presence: true, numericality: { only_integer: true }
  validates :subtotal, presence: true, numericality: { only_integer: true, greater_than: 0 }

  after_update :create_lesson_ticket, if: :should_create_lesson_ticket?

  scope :default_order, -> { order(created_at: :desc) }
  scope :paid, -> { where.not(paid_at: nil) }
  scope :unpaid, -> { where(paid_at: nil) }

  def paid!
    update!(paid_at: Time.current)
  end

  def paid?
    paid_at.present?
  end

  private

  def should_create_lesson_ticket?
    saved_change_to_paid_at? && paid?
  end

  def create_lesson_ticket
    LessonTicket.create!(user: user, purchase: self, ticket_type: ticket_type)
  end
end
