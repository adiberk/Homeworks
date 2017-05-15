class SearchController < ApplicationController
  def search

    @subject_names = CourseSubject.all

    @course_search = nil
    @subject_search = nil
    if params[:course_search] == ''
      if params[:subject_search] == ''
        @course_search = Course.all
      else
        @subject_search = CourseSubject.subject_search(params[:subject_search]).order("created_at DESC")
        @subject_search = @subject_search.select(:course_id).distinct
        @course_search = []
        @subject_search.each do |subj|
          @course_search.push(Course.find(subj.course_id))
        end
      end
    else
      @course_search = Course.course_search(params[:course_search]).order("created_at DESC")
      if params[:subject_search] != ''
        @subject_search = CourseSubject.subject_search(params[:subject_search]).order("created_at DESC")
        cr = []
        @course_search.each do |course|

            f = @subject_search.where(course_id: course.id).first
            if f != nil
              cr.push(Course.find(f.course_id))
            end
        end
        @course_search = cr
      end
    end
  end
end
