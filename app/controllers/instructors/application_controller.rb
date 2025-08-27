class Instructors::ApplicationController < ApplicationController
  before_action :authenticate_instructor!
  layout 'instructors'
end
