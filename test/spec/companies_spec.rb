require 'rspec'
require 'companies'

describe 'Companies' do

  before(:each) do
    @collection = double('Collection', :insert => nil)
    @database = double("Database", :collection => @collection)
    @companies = Companies.new(@database)
  end

  it "inserts companies in database" do
    company_data = {'name' => 'Aureka S.L.', 'verified' => false}

    @collection.should_receive(:insert).with(company_data)

    @companies.insert(company_data)
  end

  it "returns the mongo id" do
    anId = 78321321;

    @collection.should_receive(:insert).and_return(anId)

    expect(@companies.insert({})).to eql anId
  end
end