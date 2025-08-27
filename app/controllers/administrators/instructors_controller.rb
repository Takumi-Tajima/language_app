class Administrators::InstructorsController < Administrators::ApplicationController
  before_action :set_instructor, only: %i[show edit update destroy]

  def index
    @instructors = Instructor.default_order
  end

  def show
  end

  def new
    @instructor = Instructor.new
  end

  def edit
  end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      redirect_to administrators_instructors_path, notice: '講師を作成しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to administrators_instructor_path(@instructor), notice: '講師を更新しました。', status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @instructor.destroy!
    redirect_to administrators_instructors_path, notice: '講師を削除しました。', status: :see_other
  end

  private

  def set_instructor
    @instructor = Instructor.find(params.expect(:id))
  end

  def instructor_params
    params.expect(instructor: %i[name email password password_confirmation])
  end
end
