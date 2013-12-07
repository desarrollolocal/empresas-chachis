require_relative '../test_helper'

describe "Empresas chachis for companies" do
  include Capybara::DSL

  before do
    Capybara.app = MyApp.new
    database_settings = MyApp.settings.database
    @database = MongoClient.new(database_settings['host'], database_settings['port']).db(database_settings['name'])
    @database.collection("companies").drop
    @companies_collection = @database.collection("companies")
  end


  it "allows companies to register" do
    expected_companies = 1
    visit '/register-company'

    fill_in('name', { :with => 'Aureka Internet S.L.' })
    fill_in('website', { :with => 'http://www.aureka.es' })
    fill_in('email', { :with => 'jiesquiu@aureka.es' })
    click_button('Register')

    @companies_collection.find.count.should eq expected_companies
  end

  it "allows companies to verify" do
    expected_companies = 1
    id = @companies_collection.insert({'verified' => false})

    visit "/verify-company/#{id}"

    @companies_collection.find({'_id' => id, 'verified' => true}).count.should eq expected_companies
  end
end