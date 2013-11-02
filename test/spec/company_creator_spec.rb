require 'rspec'
require 'company_creator'

describe 'CompanyCreator' do
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @company_creator = CompanyCreator.new(@database)
  end


  it "newly created companies are hiring" do
    company_data = {'name' => '', 'email' => '', 'website' => ''}
    expected_insert_data = {'name' => '', 'email' => '', 'website' => '', 'hiring' => true}

    @collection.should_receive(:insert).with(expected_insert_data)

    @company_creator.create(company_data);
  end

end