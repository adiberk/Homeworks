require_relative "Ratings.rb"
class Validate
	def initialize()
		@base = Ratings.new("ml-100k", nil )
		@test = Ratings.new("ml-100k", "u3.test")
		@file = File.open("ratings.txt", "w")
	end
	attr_reader :base, :test, :file

	def validate()
		user_data = test.user_data #access user data of test file
		keys = user_data.keys #get keys of user data (so all the users)
		predict_error = 0
		num= 0
		result = [0, 0, 0]
		keys.each do |key| #loop through every user
			movie_rate = user_data[key] #get a 2d list of movie user rated, and his/her rating [[movie, rating]]
			movie_rate.each do |movie, rating| #grab both the movie and the rating
				predict = base.predict(key, movie) #take the movie and the user id and predict what the user would have rated the movie
				check_prediction(result, predict, rating, movie) #call method to compare my prediction against actual rating
				predict_error += (predict - rating.to_i).abs/rating.to_i #get percent error of each prediction (this will be averaged)
				num+=1 #count all predictions made
			end
		end
		file.puts "Average prediction error(not in % form): #{(predict_error/num*1000).to_i/1000.0}" #calculate average percent prediction error
		file.puts "Correct: #{result[0]}", "Wrong: #{result[2]}", "Close: #{result[1]}" #put down how many i got right, wrong, and close
		file.close
		puts "Average prediction error(not in % form): #{(predict_error/num*1000).to_i/1000.0}"
	end

	#calculates how may I got write, wrong or close
	def	check_prediction(result, predict, rating, movie)
		file.puts "Movie: #{movie} - My rating #{predict} VS #{rating}"
		#Rating is a whole number and my prediction is a "double" 
		#So I make a prediction correct if it is within .5 of rating  (becuase then we would round the prediction up or down)
		if predict >= (rating.to_i*1.0)-0.5 && predict < (rating.to_i*1.0)+0.5 
			result[0] +=1
		elsif (predict - rating.to_i).abs <= 1
			result[1] +=1
		else
			result[2]+=1
		end
	end
end