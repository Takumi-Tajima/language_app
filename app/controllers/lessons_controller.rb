class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]

  def index
    @lessons = Lesson.default_order
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find(params.expect(:id))
  end
end
