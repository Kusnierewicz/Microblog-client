require 'jumpstart_auth'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "mJ5otbhPGNoDCgCL7j5g"
  config.consumer_secret     = "M0XkT6GeBnjxdlWHcSGYX1JutMVS9D5ISlkqRfShg"
  config.access_token        = "2857722531-bZSzkm1Wuef2s95y7snYlveUzRwo3b8zPQoerma"
  config.access_token_secret = "eaqzBRhhuebvI9IfLTLuTrRfnCU1It4Us3PLQ5iIIb8JT"
end

client.update("I'm tweeting with @gem!")