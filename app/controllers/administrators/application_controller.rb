class Administrators::ApplicationController < ActionController::Base
  before_action :authenticate_administrator!
  allow_browser versions: :modern
  layout 'administrators'
end
