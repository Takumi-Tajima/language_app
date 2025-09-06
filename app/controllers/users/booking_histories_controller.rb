class Users::BookingHistoriesController < Users::ApplicationController
  def index
    @booking_histories = current_user.bookings.includes(lesson_schedule: { lesson: :instructor }).histories.default_order
  end
end
