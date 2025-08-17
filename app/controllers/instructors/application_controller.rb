class Instructors::ApplicationController < ActionController::Base
  before_action :authenticate_instructor!
  allow_browser versions: :modern
  layout 'instructors'
end
