class Users::LessonTicketsController < Users::ApplicationController
  def index
    @lesson_tickets = current_user.lesson_tickets.default_order
  end
end
