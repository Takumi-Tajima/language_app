class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :impersonating?

  def impersonating?
    session[:administrator_backup_id].present?
  end
end
