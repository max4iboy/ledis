require 'sinatra'
require 'sinatra/reloader'

class Ledis < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  post '/' do
  end
end
