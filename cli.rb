require 'rest-client'

url = ARGV[0] || 'http://localhost:3000'

loop do
  command = STDIN.gets.chomp
  break if command == 'exit'
  response = RestClient.post(url, command)
  p response.body
end
