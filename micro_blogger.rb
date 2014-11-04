require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
  attr_reader :client

  def initialize
  	puts "Initializing Microblogger"
  	#@client = JumpstartAuth.twitter
  	
  	@client = Twitter::REST::Client.new do |config|
  	  config.consumer_key        = "mJ5otbhPGNoDCgCL7j5g"
  	  config.consumer_secret     = "M0XkT6GeBnjxdlWHcSGYX1JutMVS9D5ISlkqRfShg"
  	  config.access_token        = "2857722531-bZSzkm1Wuef2s95y7snYlveUzRwo3b8zPQoerma"
  	  config.access_token_secret = "eaqzBRhhuebvI9IfLTLuTrRfnCU1It4Us3PLQ5iIIb8JT"
	end

  end

  def tweet(message)
  	puts "message = #{message}"
  	if message.length > 140
  	  puts "message to long"
  	else
  	  @client.update(message)
  	end
  end

  def run
  	puts "welcome to the JSL Twitter Client!"
  	command = ""
  	while command != "q"
  	  printf "enter command: "
  	  input = gets.chomp
  	  parts = input.split(" ")
  	  command = parts[0]
  	  case command
  	    when 't' then tweet(parts[1..-1].join(" "))
  	    when 'q' then puts "Goodbye!"
  	    when 'dm' then dm(parts[1], parts[2..-1].join(" "))
  	    when 'fl' then followers_list
  	   	when 'spam' then spam_my_followers(parts[1..-1].join(" "))
  	   	when 'lastT' then everyones_last_tweet
  	   	when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
  	    when 'kscore' then print_kscore_for_friends
  	    else
  	      puts "Sorry, I don't know how to #{command}"
  	  end 
  	end
  end

  def dm(target, message)
  	puts "Trying to send #{target} this message:"
  	puts message
  	screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
  	if screen_names.include?(target)
      message = "d @#{target} #{message}"
  	  tweet(message)
  	else
  	  puts "target is not following you!"
  	end
  end

  def followers_list
  	screen_names = []
  	@client.followers.each do |follower|
  	  screen_names << @client.user(follower).screen_name
  	end
  	screen_names
  end

  def spam_my_followers(message)
  	followers = followers_list
  	followers.each do |follower|
  	  dm(follower, message)
  	end
  end

  def everyones_last_tweet
  	friends = @client.friends
  	friends.each do |item|
  		puts item.screen_name
  	end
  	puts friends.methods
  	puts friends.class
  	#friends.each do |friend|
  	#  puts "#{friend.screen_name} tweeted: "
  	#  puts "#{friend.status.text}"
  	#  puts ""
  	#end
  end

  def shorten(original_url)
  	puts "Shortening this URL: #{original_url}"
  	Bitly.use_api_version_3
  	bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
	return bitly.shorten(original_url).short_url
  end

  def klout_score(name)
	Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
	identity = Klout::Identity.find_by_screen_name(name)
	user = Klout::User.new(identity.id)
	user.score.score
  end

  def print_kscore_for_friends
  	screen_names = @client.friends.collect{ |f| f.screen_name }
  	screen_names.each do |friend|
  	  print "#{friend} score is: ", klout_score(friend)
  	  puts " "
  	end
  end
end


n = MicroBlogger.new

n.run


