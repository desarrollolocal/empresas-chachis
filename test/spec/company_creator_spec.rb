require 'rspec'
require 'company_creator'
require 'mail'

Mail.defaults do
  delivery_method :test
end

describe 'CompanyCreator' do
  include Mail::Matchers
  before(:each) do
    @collection = double('Collection', :find => {})
    @database = double("Database", :collection => @collection)
    @company_creator = CompanyCreator.new(@database)

    Mail::TestMailer.deliveries.clear
  end

  it "newly created companies are hiring" do
    company_data = {'name' => '', 'email' => 'a_mail@web.com', 'website' => ''}
    expected_insert_data = {'name' => '', 'email' => 'a_mail@web.com', 'website' => '', 'hiring' => true}

    @collection.should_receive(:insert).with(expected_insert_data)

    @company_creator.create(company_data);
  end


  it "sends an email when a new company is created with a unique id" do
    @collection.stub(:insert).and_return("123mdfs5343ins")

    company = @company_creator.create({'name' => '', 'email' => 'hello@company.com', 'website' => ''});

    should have_sent_email.to('hello@company.com')
    should have_sent_email.matching_body(/#{company.id}/)

  end

end