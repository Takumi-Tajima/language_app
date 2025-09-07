class Instructors::Lessons::LessonSchedulesController < Instructors::ApplicationController
  before_action :set_lesson
  before_action :set_lesson_schedule, only: %i[show edit update destroy]

  def index
    @lesson_schedules = @lesson.lesson_schedules.default_order
  end

  def show
  end

  def new
    @lesson_schedule = @lesson.lesson_schedules.new
  end

  def edit
  end

  def create
    @lesson_schedule = @lesson.lesson_schedules.new(lesson_schedule_params)

    if @lesson_schedule.save
      redirect_to instructors_lesson_lesson_schedules_path(@lesson), notice: 'スケジュールを登録しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @lesson_schedule.update(lesson_schedule_params)
      redirect_to instructors_lesson_lesson_schedules_path(@lesson), notice: 'スケジュールを更新しました。', status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @lesson_schedule.destroy
      redirect_to instructors_lesson_lesson_schedules_path(@lesson), notice: 'スケジュールを削除しました。', status: :see_other
    else
      redirect_to instructors_lesson_lesson_schedules_path(@lesson), alert: '削除に失敗しました。', status: :see_other
    end
  end

  private

  def set_lesson
    @lesson = current_instructor.lessons.find(params.expect(:lesson_id))
  end

  def set_lesson_schedule
    @lesson_schedule = @lesson.lesson_schedules.find(params.expect(:id))
  end

  def lesson_schedule_params
    params.expect(lesson_schedule: %i[lesson_id start_at meeting_url])
  end
end
