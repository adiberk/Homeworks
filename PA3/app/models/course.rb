class Course < ApplicationRecord
	# belongs_to :enrollment
	# belongs_to :user, through: :enrollments
	# belongs_to :user
	# or...
	has_many :enrollments
	has_many :users, through: :enrollments
	# has_many :course_subjects
	# has_many :subjects, through: :course_subjects
	

	def self.course_search(search)
  		where("name LIKE ?", "%#{search}%") 
	end
end
