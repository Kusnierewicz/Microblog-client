require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
  	puts "Initializing Microblogger"
  	@client = JumpstartAuth.twitter
  end

  def tweet(message)
  	@client.update(message)
  end
end

n = MicroBlogger.new
n.tweet("Micro blog start")