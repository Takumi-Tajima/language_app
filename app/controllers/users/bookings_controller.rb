class Users::BookingsController < Users::ApplicationController
  before_action :set_lesson_schedule, only: %i[create]
  before_action :set_booking, only: %i[show]

  def index
    @bookings = current_user.bookings.default_order
  end

  def show
  end

  def create
    @booking = Booking.create_with_ticket_decrement!(user: current_user, lesson_schedule: @lesson_schedule)
    redirect_to users_bookings_path, notice: 'レッスンを予約しました'
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    redirect_to lesson_path(@lesson_schedule.lesson), alert: e.message
  end

  def destroy
  end

  private

  def set_lesson_schedule
    @lesson_schedule = LessonSchedule.find(params.expect(:lesson_schedule_id))
  end

  def set_booking
    @booking = current_user.bookings.find(params.expect(:id))
  end
end
