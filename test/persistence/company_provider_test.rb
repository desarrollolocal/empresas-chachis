require 'rspec'

require_relative '../../lib/company_provider'

describe 'CompanyProvider' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @company_provider = CompanyProvider.new(@database)
  end

  it 'looks for companies in the database' do
    @collection.should_receive('find').once

    @company_provider.find_all
  end

  it 'brings all the companies found' do
    database_rows = [{},{},{}]
    @collection.should_receive('find').and_return(database_rows)

    companies = @company_provider.find_all

    expect(companies.count).to be 3
  end

end