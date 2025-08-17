class Instructors::SessionsController < Devise::SessionsController
  layout 'instructors'

  def after_sign_in_path_for(resource)
    instructors_root_path
  end

  def after_sign_out_path_for(resource)
    new_instructor_session_path
  end
end
