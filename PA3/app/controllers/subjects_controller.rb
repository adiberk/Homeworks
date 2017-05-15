class SubjectsController < ApplicationController
  before_action :require_login
  def show
  	@subjects = Subject.all
  end

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
