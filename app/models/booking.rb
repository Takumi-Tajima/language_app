class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_schedule
  belongs_to :lesson_ticket

  validates :user_id, uniqueness: { scope: :lesson_schedule_id }
  validate :validate_no_overlap_other_bookings

  scope :default_order, -> { order(:id) }

  delegate :start_at, to: :lesson_schedule
  delegate :end_at, to: :lesson_schedule

  def lesson_name
    lesson_schedule.lesson.name
  end

  def lesson_language
    lesson_schedule.lesson.language_text
  end

  def instructor_name
    lesson_schedule.lesson.instructor.name
  end

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

  def validate_no_overlap_other_bookings
    if user.bookings.where.not(id:).joins(:lesson_schedule).exists?(['lesson_schedules.start_at < ? AND lesson_schedules.end_at > ?', lesson_schedule.end_at,
                                                                     lesson_schedule.start_at])
      errors.add(:base, '他の予約と時間が重複しています')
    end
  end
end
