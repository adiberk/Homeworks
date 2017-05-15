class Subject < ApplicationRecord
	# has_many :course_subjects
	# has_many :courses, through: :course_subjects
	def self.subject_search(search)
  		where("name LIKE ?", "%#{search}%") 
	end
end
