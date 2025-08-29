class Instructors::RegistrationsController < Devise::RegistrationsController
  layout 'instructors'

  protected

  def after_update_path_for(resource)
    instructors_profile_path
  end
end
