require 'sinatra'
require 'sinatra/reloader'
require 'drb'
require './lib/command'

DRb.start_service

class Ledis < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure :production, :development do
    enable :logging
  end

  get '/' do
    slim :index
  end

  post '/' do
    begin
      command_string = params.first[0]
      command = Command.parse_from(command_string.split.first.downcase)
      remote_mem = DRbObject.new_with_uri('druby://localhost:9999')
      command.run(remote_mem, command_string)
    rescue => e
      logger.info(e.message)
      'ERROR!'
    end
  end
end
