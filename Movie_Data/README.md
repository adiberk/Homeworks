Adi Berkowitz <br />
Movies Part 2
<br />
NOTE/WARNING: It is possible for mac users to get a UTF8 error.  If so, you need to add extra information to my .split call in my ratings method
<br />
<br />
HW: in this assignment we were told to create an alagorithm that predicts a rating that a user would give a movie

Discussion:
- you can find my prediction algorithm in my Ratings.rb file/class. <br />
- I then intialize the Raings class in my validator class and then run my validator through the Control class (int the control.rb file)
- I create a file, ratings.txt, which shows my predictions vs. the actual ratings.  At the end it contains some information about how many were correct, wrong, or close as well as prediction error <br />
- Those results can also be found after the information below

Algorithm: My algorithm bases its prediction rating off of the ratings that user u has given to the genres of all the movies user u has rated So first I access the file u.item which contains a description of every movie rated and lists each movies genres. I store this information in a hash (movieId => [list of genres]). I use this information later. I then gather data about the user and store that data in a hash (userId => [[movie, rating]]). The value of the userId is a 2d array with every movie and the rating the user has rated (and its rating). Now I use both of this information to make a new hash that contains a userId as its key and another hash as its value. This other hash contains a rating as its value and a list of the ratings that user u has given movies of that genre ({userId => {genre => [list of ratings]} }). So for example, say user x rated movie y with a rating of 4. say movie Y was a mix of genres a,b and c. So my data will look as such

	(user_x => {a=>4, b=>4, c=>4}).  

Now we have the rating that the user gave the genres of that movie.
Now that I have all this information I can make a prediction about what rating user x will give movie i. I make this prediction by grabbing the genres of movie i. I then look at the genres that user x rated and then add up the ratings and find the average. That becomes my prediction!!! 
<br />
<br />
Statistics and other information requried:
- Github url: https://github.com/adiberk/Movie_Data
- Average prediction error (not in % form) 0.326 <br />
- Algorithm finished in 0.7s <br />
- Correct: 7519 <br />
- Wrong: 6322 <br />
- Close: 6159 <br />
- Link to codeclimate: https://codeclimate.com/github/adiberk/Movie_Data
- I think that the advantage of my algorithm is that it takes into consideration the users taste in certain genres.  It looks like it has a low average of prediction error.  It is also rather fast. <i>Of course</i>, it is not perfect.  One clear weakness is that a user might give a terrible rating to a certain genre, but then give a great rating to that same genre for a different movie.  Clearly, there might not be a relationship between those ratings.  So in a way, my algorithm is a basic prediction that can be made using that information.  <strong>It could</strong> be more accurate if I only take the ratings the user made of those same combined genres as the movie I am being asked to rate! However, I would need much more info about suer preferences becuase there might not be many ratings of movies that have the exact genre combination match
- I actually think that overall my algorithm will perform pretty well even with an exponential increase in the amount of information.  I say this because it only takes my program .7 seconds to parse through 100000 lines of information.  And obviously it will slow down given larger files, however, I think the running time will not be as exponentially large compared to the exponential increase in file size (or lines etc.)

