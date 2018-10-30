require 'rest-client'

url = 'http://localhost:3000'

loop do
  command = gets.chomp
  break if command == 'exit'
  response = RestClient.post(url, command)
  p response.body
end
