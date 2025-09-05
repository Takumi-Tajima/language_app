class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_schedule
  belongs_to :lesson_ticket

  validates :user_id, uniqueness: { scope: :lesson_schedule_id }
  validate :validate_lesson_ticket_remaining_count

  scope :default_order, -> { order(:id) }

  def self.create_with_ticket_decrement!(user:, lesson_schedule:)
    ticket = user.available_lesson_ticket

    transaction do
      raise ActiveRecord::RecordNotFound, '予約に失敗しました。保有しているチケットの内容をご確認いただくか、他のレッスン予約状況をご確認ください。' if ticket.nil?

      booking = user.bookings.create!(lesson_schedule: lesson_schedule, lesson_ticket: ticket)
      ticket.decrement_remaining_count!
      booking
    end
  end

  private

  def validate_lesson_ticket_remaining_count
    if lesson_ticket.remaining_count <= 0
      errors.add(:lesson_ticket, '利用可能なレッスンチケットがありません')
    end
  end
end
