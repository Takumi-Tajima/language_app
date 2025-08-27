class Administrators::Instructors::ImpersonationsController < Administrators::ApplicationController
  before_action :set_instructor

  def create
    session[:administrator_backup_id] = current_administrator.id
    sign_in @instructor
    redirect_to instructors_root_path, notice: '講師として代理ログインしました。'
  end

  def destroy
    sign_out current_instructor if instructor_signed_in?
    redirect_to administrators_root_path, notice: '管理者に戻りました。', status: :see_other
  end

  private

  def set_instructor
    @instructor = Instructor.find(params.expect(:instructor_id))
  end
end
