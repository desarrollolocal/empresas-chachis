$: << File.join(File.dirname(__FILE__), 'lib')
ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/partial'
require 'json'
require 'mongo'
require 'json/ext'
require 'company_provider'
require 'keyword_provider'

class MyApp < Sinatra::Base
  register Sinatra::ConfigFile
  register Sinatra::Partial
  include Mongo

  config_file './config/config.yml'

  configure do
    conn = MongoClient.new(settings.database['host'], settings.database['port'])
    set :mongo_db, conn.db(settings.database['name'])
  end

  get '/:keyword?' do |keyword|
    provider  = CompanyProvider.new(settings.mongo_db)
    keywords = KeywordProvider.new(settings.mongo_db).find_all
    companies = provider.find_hiring(keyword)

    haml :list, :format => :html5, :locals => { :companies => companies, :keywords => keywords } 
  end

end