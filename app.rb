require 'sinatra'
require 'sinatra/reloader'
require 'drb'
require './lib/command'

DRb.start_service

class Ledis < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    require 'pry'
  end

  configure :production, :development do
    enable :logging
  end

  get '/' do
    slim :index
  end

  post '/' do
    begin
      return 'ERROR!' unless params[:cmd]
      command_string = params[:cmd]
      command = Command.parse_from(command_string.split.first.to_s.downcase)
      remote_mem = DRbObject.new_with_uri('druby://localhost:9999')
      command.run(remote_mem, command_string.split(' ')[1..-1])
    rescue => e
      logger.info(e.message)
      case e
      when DRb::DRbRemoteError
        if e.reason == "WrongTypeError"
          e.message
        else
          'ERROR!'
        end
      when Commands::Command::WrongArgumentsNumberError,Commands::Command::InvalidIntegerError
        e.message
      else
        'ERROR!'
      end
    end
  end
end
