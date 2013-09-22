require 'sinatra/base'
require 'json'

class MyApp < Sinatra::Base

  get '/' do
    {:say => "Hello World"}.to_json
  end

end