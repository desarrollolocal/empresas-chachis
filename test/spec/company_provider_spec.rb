require 'rspec'

require_relative '../../lib/company_provider'

describe 'CompanyProvider' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @company_provider = CompanyProvider.new(@database)
  end

  it 'filters hiring companies' do
    filters = double('CompanyFilters')
    CompanyFilters.should_receive(:new).and_return(filters)

    filters.should_receive(:add).with('hiring', true);

    @company_provider.find_hiring
  end

  it 'filters hiring companies by keyword' do
    keyword = 'ruby'
    filter_mock = double('CompanyFilters')
    @company_provider.stub(:default_filters).and_return(filter_mock)

    filter_mock.should_receive(:add_keyword).with(keyword)

    companies = @company_provider.find_hiring(keyword)
  end

  it 'queries the database with the filters built' do
    companies = [{}, {}]
    @collection.should_receive(:find) do |filters|
      expect(filters.class).to eql CompanyFilters
    end
    .and_return(companies)

    @company_provider.find_hiring
  end

end