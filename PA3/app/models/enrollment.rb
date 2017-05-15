class Enrollment < ApplicationRecord
	# has_many :users
	belongs_to :user
	# has_many :courses
	belongs_to :course
	validates_uniqueness_of :course_id, :scope => :user_id
end
