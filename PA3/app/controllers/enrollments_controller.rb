class EnrollmentsController < ApplicationController
  def new
  	@enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    # respond_to do |format|
      if @enrollment.save
     		redirect_to current_user
        flash[:success] = 'Successfully enrolled in course'
    	else
        redirect_to :back
        flash.now[:danger] = 'Already enrolled in course'
    	end
    # end
  end
  def show
  end
  private
  	def enrollment_params
  	    params[:enrollments].permit(:course_id, :user_id)
  	end
end
