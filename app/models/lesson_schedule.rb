class LessonSchedule < ApplicationRecord
  LESSON_DURATION_MINUTES = 50.minutes

  belongs_to :lesson

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :meeting_url, presence: true
  validates :is_booked, inclusion: { in: [true, false] }
  validate :validate_no_overlap_lesson_schedules

  before_validation :set_end_at

  scope :default_order, -> { order(:start_at) }

  private

  def set_end_at
    self.end_at = start_at + LESSON_DURATION_MINUTES
  end

  def validate_no_overlap_lesson_schedules
    if lesson.instructor.lesson_schedules.where.not(id:).exists?(['start_at < ? AND end_at > ?', end_at, start_at])
      errors.add(:base, '他のレッスンと重複しています')
    end
  end
end
