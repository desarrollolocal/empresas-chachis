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
    @companies_collection = @database.collection("companies")
  end

  after do
    @database.collection("companies").drop
  end

  it "shows all the companies hiring currently" do
    expected_companies = 3
    expected_companies.times do |i| create_company(i) end

    visit '/'

    page.all('.company').count.should eql expected_companies
  end

  private

  def create_company (name)
    @companies_collection.insert({ "name" => "Company #{name}", "hiring" => true })
  end

end