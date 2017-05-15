class InstructorsController < ApplicationController
  before_action :require_login
  
  def show
  	@instructors = Instructor.all
  end

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
