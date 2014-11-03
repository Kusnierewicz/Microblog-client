require 'jumpstart_auth'

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
  	    else
  	      puts "Sorry, I don't know how to #{command}"
  	  end 
  	end
  end

end

n = MicroBlogger.new

n.run


