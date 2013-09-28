require 'sinatra/base'
require 'json'

class MyApp < Sinatra::Base

  get '/' do
    @companies = [
    { :name => 'Aureki', :address => 'Tarongers', :website => 'http://aureki.es',
      :logo => "http://aureki.jpg", :email => 'hello@aureki.es' },
    { :name => 'fruteria manolo', :address => 'Tarongers', :website => 'http://manolito.es',
      :logo => "http://manolito.jpg", :email => 'hello@manolito.es' },
    { :name => 'charcuteria valenciana', :address => 'Tarongers', :website => 'http://valencia.es',
      :logo => "http://valencia.jpg", :email => 'hello@valencia.es' }
    ]

    haml :index, :format => :html5
  end

end