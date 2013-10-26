require_relative '../test_helper'
require 'rspec'
require 'capybara'
require 'mongo'
require 'json/ext'

include Mongo

describe "Empresas chachis for students" do
  include Capybara::DSL

  before do
    Capybara.app = MyApp.new
    database_settings = MyApp.settings.database
    @database = MongoClient.new(database_settings['host'], database_settings['port']).db(database_settings['name'])
    @database.collection("companies").drop
    @companies_collection = @database.collection("companies")
  end


  it "shows all the companies hiring currently" do
    expected_companies = 3
    expected_companies.times do |i| create_company(i) end

    visit '/'

    page.all('.company').count.should eql expected_companies
  end


  it "shows companies keywords" do
    keywords = ["Ruby", "Sinatra"]
    create_company_with_keyword(keywords)

    visit '/'

    page.all('.company .keyword').count.should eql keywords.count
  end


  it "filter companies by keyword" do
    expected_companies = 1
    create_company_with_keyword(["Ruby", "Sinatra"])
    create_company_with_keyword(["PHP", "Symfony"])

    visit '/ruby'

    page.all('.company').count.should eql expected_companies
  end


  it "shows the current keywords" do
    create_company_with_keyword(["Ruby", "Sinatra"])
    create_company_with_keyword(["PHP", "Ruby"])

    visit '/'

    page.all('.keywords .keyword').count.should eql 3
  end


  private

  def create_company (name)
    @companies_collection.insert({ "name" => "Company #{name}", "hiring" => true , "keywords" => [] })
  end

  def create_company_with_keyword(keywords)
    @companies_collection.insert({ "name" => "Company name", "hiring" => true, "keywords" => keywords })
  end

end