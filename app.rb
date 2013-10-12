require 'sinatra/base'
require 'json'
require 'mongo'
require 'json/ext'

require_relative 'lib/company_provider.rb'

class MyApp < Sinatra::Base

  include Mongo

  configure do
    conn = MongoClient.new("localhost", 27017)
    set :mongo_db, conn.db('empresaschachis_test')
  end

  get '/' do
    provider  = CompanyProvider.new(settings.mongo_db)
    keyword = params[:keyword]
    companies = provider.find_hiring(keyword)

    haml :index, :format => :html5, :locals => { :companies => companies } 
  end

end