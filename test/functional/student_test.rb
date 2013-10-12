require_relative '../../app'
require 'rspec'
require 'capybara'
require 'mongo'
require 'json/ext'

include Mongo

describe "Empresas chachis" do
  include Capybara::DSL

  before do
    Capybara.app = MyApp.new
    @database = MongoClient.new("localhost", 27017).db("empresaschachis_test")
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

    page.all('.company .tag').count.should eql keywords.count
  end

  it "filter companies by keyword" do
    expected_companies = 1
    create_company_with_keyword(["Ruby", "Sinatra"])
    create_company_with_keyword(["PHP", "Symfony"])

    visit '/?keyword=ruby'

    page.all('.company').count.should eql expected_companies
  end

  private

  def create_company (name)
    @companies_collection.insert({ "name" => "Company #{name}", "hiring" => true , "keywords" => [] })
  end

  def create_company_with_keyword(keywords)
    @companies_collection.insert({ "name" => "Company name", "hiring" => true, "keywords" => keywords })
  end

end