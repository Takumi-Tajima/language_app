class Instructors::ProfilesController < Instructors::ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_instructor.update(instructor_params)
      redirect_to instructors_profile_path, notice: '更新しました。', status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def instructor_params
    params.expect(instructor: [:name, :introduction, { teachable_language: [] }])
  end
end
