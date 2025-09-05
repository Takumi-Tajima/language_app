class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_schedule
  belongs_to :lesson_ticket

  validates :user_id, uniqueness: { scope: :lesson_schedule_id }

  scope :default_order, -> { order(:id) }
end
