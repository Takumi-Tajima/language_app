class Administrators::InstructorsController < Administrators::ApplicationController
  before_action :set_instructor, only: %i[show edit update destroy]

  def index
    @instructors = Instructor.all
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
      redirect_to administrators_instructor_path(@instructor), notice: '講師を作成しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to administrators_instructor_path(@instructor), notice: '講師を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instructor.destroy!
    redirect_to administrators_instructors_path, notice: '講師を削除しました。'
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :password, :password_confirmation, :introduction)
  end
end
