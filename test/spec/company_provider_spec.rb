require 'rspec'

require_relative '../../lib/company_provider'

describe 'CompanyProvider' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @company_provider = CompanyProvider.new(@database)
  end

  it 'filters hiring companies' do
    hiring_companies = [{}, {}]
    @collection.should_receive('find').with({ "hiring" => true }).and_return(hiring_companies);

    companies = @company_provider.find_hiring
  end

  it 'filters hiring companies by keyword' do
    keyword = 'ruby'
    hiring_companies = [{}, {}]
    @collection.should_receive('find').with({ "hiring" => true, "keywords" => /^#{keyword}$/i }).and_return(hiring_companies);

    companies = @company_provider.find_hiring(keyword)
  end
end