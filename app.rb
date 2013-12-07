$: << File.join(File.dirname(__FILE__), 'lib')
ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/partial'
require 'json'
require 'mongo'
require 'json/ext'
require 'companies'
require 'company_creator'
require 'keyword_provider'
require 'verification_url_builder'

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

  get '/verify-company/:id' do |id|
    companies.update(id, {'verified' => true})

    redirect '/'
  end

  get '/:keyword?' do |keyword|
    locals = {
      :companies => companies.find_hiring(keyword),
      :keywords => keyword_provider.find_from_hiring_companies()
    }
    haml :list, :format => :html5, :locals => locals
  end


  private

  def companies
    Companies.new(settings.mongo_db)
  end

  def verification_url_builder
    builder ||= VerificationUrlBuilder.new(request.host, '/verify-company')
  end

  def company_creator
    creator ||= CompanyCreator.new(companies, verification_url_builder)
  end

  def keyword_provider
    provider ||= KeywordProvider.new(settings.mongo_db)
  end

end
