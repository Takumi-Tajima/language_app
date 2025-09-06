class Instructors::BookedLessonSchedulesController < Instructors::ApplicationController
  def index
    @booked_lesson_schedules = current_instructor.lesson_schedules.includes(:lesson).booked.default_order
  end
end
