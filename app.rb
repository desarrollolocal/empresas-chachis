$: << File.join(File.dirname(__FILE__), 'lib')
ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/config_file'
require 'json'
require 'mongo'
require 'json/ext'
require 'company_provider'

class MyApp < Sinatra::Base
  register Sinatra::ConfigFile
  include Mongo

  config_file './config/config.yml'

  configure do
    conn = MongoClient.new(settings.database['host'], settings.database['port'])
    set :mongo_db, conn.db(settings.database['name'])
  end

  get '/:keyword?' do |keyword|
    provider  = CompanyProvider.new(settings.mongo_db)
    companies = provider.find_hiring(keyword)

    haml :index, :format => :html5, :locals => { :companies => companies } 
  end

end