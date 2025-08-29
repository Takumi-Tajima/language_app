class LessonSchedule < ApplicationRecord
  LESSON_DURATION_MINUTES = 50.minutes

  belongs_to :lesson

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :meeting_url, presence: true
  validates :is_booked, inclusion: { in: [true, false] }

  before_validation :set_end_at

  scope :default_order, -> { order(:start_at) }

  private

  def set_end_at
    self.end_at = start_at + LESSON_DURATION_MINUTES
  end
end
