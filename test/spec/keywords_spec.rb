require 'rspec'
require 'keywords'

describe 'Keywords' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @keywords = Keywords.new(@database)
  end

  it 'retrieves keywords of hiring companies' do
    @collection.should_receive(:find).with({ 'hiring' => true });

    @keywords.find_from_hiring_companies
  end

  it 'returns a map of keyword appearances' do
    @collection.stub(:find).with({ 'hiring' => true }).and_return([a_company, a_company]);

    keywords = @keywords.find_from_hiring_companies

    expect(keywords['key1']).to eql 2
    expect(keywords['not found']).to be_nil
  end


  private

  def a_company
    Company.new('id', 'a_name', 'an_address', 'a_website', 'a_logo', 'an_email', ['key1'])
  end

end