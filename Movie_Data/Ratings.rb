# encoding: utf-8
class Ratings
	def initialize(folder, file)
		@folder = folder
		@file = file
		@user_data = Hash.new
		@movie_genre = Hash.new
		@user_genre_r = Hash.new
		loadData()
	end
	attr_reader :file, :folder, :user_data, :user_movie, :movie_genre, :user_genre_r
	def loadData()
		f = nil
		if file == nil
			if File.exist?("#{folder}/u3.base") == false
				puts "file does not exist"
				exit(0)
			else
				f = File.open("#{folder}/u3.base", "r")
			end
		else
			if File.exist?("#{folder}/#{file}") == false
				puts "file does not exist"
				exit(0)
			else
				f = File.open("#{folder}/#{file}", "r")
			end
		end
		movie_genres() #call to get the genre of every movie
		user_setup(f) #call to set-up and organize the information
	end

	def movie_genres()
		itemFile = File.open("#{folder}/u.item", "r")
		itemFile.each do |item|
			info = item.split("|")
			# s = info[0]
			count = 5 #begin at 5 because that is where the first genre is
			arr = Array.new
			while count <= 23 #end at 23 becuase that is where the last genre is
				if info[count].to_i == 1
					arr.push(count) #count will now be my genre id (so if 2 movies have "5" in arr -> means both have same genre)
				end
				count+=1
			end
			#info[0]  is the movie id
			movie_genre[info[0]] = arr
		end
		itemFile.close
	end
=begin
	User Setup initiates two different variables.
		1. User_data varaible which contains a key (user) and each movie and rating that user gave that movie
		2. user_genre_r which is a hash that contains key (user) => another hash key (genre) and all ratings 
		the user movies of that genre 
=end
	def user_setup(f)
		genre_rating = nil
		f.each do |line|
			id, mov, rate = line.split(" ")

			if user_data.key?(id) #need to check if we already have this user, so that we can just add to the array that key
				user_data[id] = user_data[id].push([mov, rate]) #every key user has value of user => [ [mov, rate], [mov, rate]]
			else   #if key does not exist, that means we are looking at the next user_id
				user_data[id] = [[mov, rate]] #create new key of id and a new 2d array with [mov, rate]
				genre_rating = Hash.new # this resets on new user_id becuase it should only hold all info about genres and ratings
				#for each user specifically
				user_genre_r[id] = genre_rating #add id to user_genre_r which now has value of whatver we end up adding to genre_rating
			end
			g_rate(genre_rating, mov, rate) #method to put together all info into genre_rating
		end
		f.close

	end
	def g_rate(genre_rating, mov, rate)
		genres = movie_genre[mov] #get list of the genres of this movie

		rate = rate.to_i
		genres.each do |y|
			if genre_rating.key?(y) == false
				genre_rating[y] = [rate]
			else
				genre_rating[y] = genre_rating[y].push(rate)
			end
		end
	end

	#*************Instance Methods********************#
	def rating(u, m) #method is not used, but it is still a usefull method, so did not remove
		list = user_data[u.to_s]
		if list == nil
			return "0"
		end
		list.each do |mov, rating|
			if (mov.to_i == m.to_i)
				return rating
			end
		end
		return "0"
	end
	#prediction works as follows: get the different genres of movie m.  Look at hash variable "user_genre_r" and get
	#the ratings that user u gave to those genres ()
	def predict(u, m)
		list = movie_genre[m.to_s] #get list of genres of movie m
		genre_info = user_genre_r[u.to_s] # get ratings of each genre made by user u
		if genre_info == nil || list == nil #making sure that I can actually make a prediction
			return "Sorry, info not found"
		end
		hold_info = Array.new
		i = 0
		list.each do |genre|
			sum = 0
			ratings = genre_info[genre]
			if ratings == nil #if user never rated the movie with that genre, then we skip and don't use that genre
				next
			else
				ratings.map{|x| sum+=x} #add all the ratings of that genre together

				hold_info[i] = (sum*1.0/ratings.length) #holds average of the ratings of that genre
			end
			i+=1
		end
		sum_avg_ratings = 0 # will be used in the maping below
		hold_info.map{|x| sum_avg_ratings+=x}
		if hold_info.length == 0 #if no prediction can be made -> I simply return the prediction of 4
			return 4
		end
		return ((sum_avg_ratings/hold_info.length)*100).to_i/100.0
	end

end