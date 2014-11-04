require 'bitly'

Bitly.use_api_version_3

bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
puts bitly.shorten('http://jumpstartlab.com/courses/').short_url