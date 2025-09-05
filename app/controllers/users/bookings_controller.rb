class Users::BookingsController < Users::ApplicationController
  before_action :set_lesson_schedule, only: %i[create]
  before_action :set_booking, only: %i[show]

  def index
    @bookings = current_user.bookings.default_order
  end

  def show
  end

  def create
    @booking = current_user.bookings.build(lesson_schedule: @lesson_schedule, lesson_ticket: current_user.lesson_tickets.first)
    if @booking.save
      redirect_to users_bookings_path, notice: 'レッスンを予約しました'
    else
      redirect_to lesson_path(@lesson_schedule.lesson), alert: 'レッスンの予約に失敗しました'
    end
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
