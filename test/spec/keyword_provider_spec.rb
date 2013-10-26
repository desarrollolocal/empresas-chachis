require 'rspec'
require 'keyword_provider'

describe 'KeywordProvider' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @keyword_provider = KeywordProvider.new(@database)
  end

  it 'retrieves keywords of hiring companies' do
    @collection.should_receive(:find).with({ 'hiring' => true });

    @keyword_provider.find_from_hiring_companies
  end
end