require 'rspec'
require 'company_provider'

describe 'CompanyProvider' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @company_provider = CompanyProvider.new(@database)
  end

  it 'filters hiring companies' do
    expected_filters = { 'hiring' => true }

    @collection.should_receive(:find).with(expected_filters);

    @company_provider.find_hiring
  end

  it 'allows filtering by keyword' do
    keyword = 'ruby'
    expected_filters = { 'hiring' => true, 'keywords' => /^#{keyword}$/i }

    @collection.should_receive(:find).with(expected_filters);

    companies = @company_provider.find_hiring(keyword)
  end

end