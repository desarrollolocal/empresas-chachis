$: << File.join(File.dirname(__FILE__), 'lib')
ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/partial'
require 'json'
require 'mongo'
require 'json/ext'
require 'company_provider'
require 'company_creator'
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

  get '/register-company' do
    haml :register_company, :format => :html5
  end

  post '/register-company' do
    company_creator.create(params)
    redirect '/register-company'
  end

  get '/:keyword?' do |keyword|
    haml :list, :format => :html5, :locals => { :companies => companies(keyword), :keywords => keywords }
  end


  private

  def companies(keyword)
    company_provider.find_hiring(keyword)
  end

  def keywords
    keyword_provider.find_from_hiring_companies()
  end

  def company_provider
    provider ||= CompanyProvider.new(settings.mongo_db)
  end

  def company_creator
    creator ||= CompanyCreator.new(settings.mongo_db)
  end

  def keyword_provider
    provider ||= KeywordProvider.new(settings.mongo_db)
  end

end
