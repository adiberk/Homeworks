class CourseSubject < ApplicationRecord
	validates_uniqueness_of   :course_id, scope: :subject_name
	# validates :course_id, uniqueness: { scope: :subject_id }
	# belongs_to :course
	# belongs_to :subject
	def self.subject_search(search)
  		where("subject_name LIKE ?", "%#{search}%") 
	end
end
