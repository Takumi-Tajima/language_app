class Users::BookingsController < Users::ApplicationController
  before_action :set_lesson_schedule, only: %i[create]
  before_action :set_booking, only: %i[show]

  def index
    @bookings = current_user.bookings.default_order
  end

  def show
  end

  def create
    ticket = current_user.available_lesson_ticket

    if ticket.nil?
      redirect_to lesson_path(@lesson_schedule.lesson), alert: '利用可能なレッスンチケットがありません。レッスンチケットを購入してください。' and return
    end

    @booking = current_user.bookings.build(lesson_schedule: @lesson_schedule, lesson_ticket: ticket)

    if @booking.save
      ticket.decrement_remaining_count!
      redirect_to users_bookings_path, notice: 'レッスンを予約しました'
    else
      redirect_to lesson_path(@lesson_schedule.lesson), alert: 'レッスンの予約に失敗しました。チケットを確認するか、他のレッスンとの予約が重複していないか確認してください。'
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
