class Instructors::AccountsController < Instructors::ApplicationController
  def edit
  end

  def update
    if current_instructor.update_with_password(account_params)
      bypass_sign_in(current_instructor)
      redirect_to instructors_account_path, notice: 'アカウント情報を更新しました。', status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def account_params
    params.require(:instructor).permit(:email, :password, :password_confirmation, :current_password)
  end
end
