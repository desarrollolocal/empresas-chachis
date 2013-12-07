require 'rspec'
require 'companies'
require 'json/ext'
require 'mongo'

describe 'Companies' do
  include Mongo

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

  it "returns the company instance when inserting" do
    expect(@companies.insert({}).class).to be Company
  end

  it 'filters hiring companies' do
    expected_filters = { 'hiring' => true }

    @collection.should_receive(:find).with(expected_filters);

    @companies.find_hiring
  end

  it 'allows filtering by keyword' do
    keyword = 'ruby'
    expected_filters = { 'hiring' => true, 'keywords' => /^#{keyword}$/i }

    @collection.should_receive(:find).with(expected_filters);

    @companies.find_hiring(keyword)
  end

  it 'updates companies by id' do
    id = '52a30e62cea0997526000001'
    updated_fields = { 'hiring' => false, 'verified' => true }

    @collection.should_receive(:update).with({'_id' => BSON::ObjectId(id)}, {'$set' => updated_fields});

    @companies.update(id, updated_fields)
  end
end