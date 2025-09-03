class Users::LessonTicketsController < ApplicationController
  def index
    @lesson_tickets = current_user.lesson_tickets.default_order
  end
end
