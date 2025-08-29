class Instructors::LessonsController < Instructors::ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]

  def index
    @lessons = current_instructor.lessons.default_order
  end

  def show
  end

  def new
    @lesson = current_instructor.lessons.build
  end

  def edit
  end

  def create
    @lesson = current_instructor.lessons.build(lesson_params)

    if @lesson.save
      redirect_to instructors_lesson_path(@lesson), notice: 'レッスンを作成しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to instructors_lesson_path(@lesson), notice: 'レッスンを更新しました。', status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @lesson.destroy!
    redirect_to instructors_lessons_path, notice: 'レッスンを削除しました。', status: :see_other
  end

  private

  def set_lesson
    @lesson = current_instructor.lessons.find(params.expect(:id))
  end

  def lesson_params
    params.expect(lesson: %i[name description language])
  end
end
