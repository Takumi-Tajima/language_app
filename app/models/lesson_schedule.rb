class LessonSchedule < ApplicationRecord
  LESSON_DURATION_MINUTES = 50.minutes

  belongs_to :lesson
  has_one :booking, dependent: :destroy

  validates :start_at, presence: true
  validates :end_at, comparison: { greater_than: :start_at }
  validates :meeting_url, presence: true
  validate :validate_no_overlap_lesson_schedules

  before_validation :set_end_at
  before_update :do_not_update_start_at_if_booking_present
  before_destroy :do_not_destroy_if_booking_present

  scope :default_order, -> { order(:start_at) }
  scope :bookable, -> { where(is_booked: false).where('start_at > ?', Time.current) }
  scope :booked, -> { where(is_booked: true) }

  def self.ransackable_attributes(auth_object = nil)
    %w[start_at end_at]
  end

  def book!
    update!(is_booked: true)
  end

  def unbook!
    update!(is_booked: false)
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

  def do_not_destroy_if_booking_present
    if is_booked?
      errors.add(:base, '予約が存在するため削除できません')
      throw(:abort)
    end
  end

  def do_not_update_start_at_if_booking_present
    if is_booked?
      errors.add(:base, '予約が存在するため、開始時刻の変更はできません。ユーザーと直接やりとりをしてください。')
      throw(:abort)
    end
  end
end
