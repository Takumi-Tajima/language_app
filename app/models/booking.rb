class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_schedule
  belongs_to :lesson_ticket

  validates :user_id, uniqueness: { scope: :lesson_schedule_id }
  validate :validate_lesson_ticket_remaining_count

  scope :default_order, -> { order(:id) }

  private

  def validate_lesson_ticket_remaining_count
    if lesson_ticket.remaining_count <= 0
      errors.add(:lesson_ticket, '利用可能なレッスンチケットがありません')
    end
  end
end
