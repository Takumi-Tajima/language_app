class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]

  def index
    @q = Lesson.ransack(params[:q])
    @lessons = @q.result(distinct: true).default_order
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find(params.expect(:id))
  end
end
