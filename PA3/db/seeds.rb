require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Instructor.destroy_all
Course.destroy_all
Subject.destroy_all
User.destroy_all
Enrollment.destroy_all

user = User.create(name: "Example User", email: "user@example.com", 
			password: "foobar", password_confirmation: "foobar")

subjects = JSON.parse(File.read("#{Rails.root}/public/subject.json"))
count = 0
subjects.each do
	Subject.create(name: subjects[count]["name"], abbreviation: subjects[count]["abbreviation"], 
					term: subjects[count]["term"], segments: subjects[count]["segments"].to_json, subject_id: subjects[count]["id"])
	count+=1;
end

courses = JSON.parse(File.read("#{Rails.root}/public/course.json"))
count = 0
courses.each do

	c = Course.create(name: courses[count]["name"], description:courses[count]["description"], 
					code: courses[count]["code"], term: courses[count]["term"], subjects: courses[count]["subjects"].to_json)
	count+=1
	# user.enrollments.create(course_id: c.id)
	# add relational course_subject stuff
	subject = JSON.parse(c.subjects)
	sub_count = 0
	subject.each do
		id = subject[sub_count]["id"]
		subj = Subject.where(subject_id: id).first

		if subj != nil
			CourseSubject.create(course_id: c.id, subject_name: subj.name)
		end
		sub_count+=1
	end
end


instructors = JSON.parse(File.read("#{Rails.root}/public/instructor.json"))
count = 0
instructors.each do
	Instructor.create(first_name: instructors[count]["first"], middle_name: instructors[count]["middle"], 
						last_name: instructors[count]["last"], email: instructors[count]["email"])
	count+=1;
end
