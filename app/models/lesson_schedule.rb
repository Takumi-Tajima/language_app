class LessonSchedule < ApplicationRecord
  LESSON_DURATION_MINUTES = 50.minutes

  belongs_to :lesson

  validates :start_at, presence: true
  validates :end_at, comparison: { greater_than: :start_at }
  validates :meeting_url, presence: true
  validate :validate_no_overlap_lesson_schedules

  before_validation :set_end_at

  scope :default_order, -> { order(:start_at) }
  scope :bookable, -> { where(is_booked: false).where('start_at > ?', Time.current) }

  def self.ransackable_attributes(auth_object = nil)
    %w[start_at end_at]
  end

  def book!
    update!(is_booked: true)
  end

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
