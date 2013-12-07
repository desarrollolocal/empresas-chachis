require 'rspec'
require 'company_creator'
require 'mail'

Mail.defaults do
  delivery_method :test
end

describe 'CompanyCreator' do
  include Mail::Matchers
  before(:each) do
    @companies = double("Companies", :insert => nil)
    @verification_url_builder = double("VerificationUrlBuilder", :build => '')
    @company_creator = CompanyCreator.new(@companies, @verification_url_builder)

    Mail::TestMailer.deliveries.clear
  end

  it "newly created companies are hiring and unverified" do
    company_data = {'name' => '', 'email' => 'a_mail@web.com', 'website' => ''}
    expected_insert_data = {'name' => '', 'email' => 'a_mail@web.com', 'website' => '', 'hiring' => true, 'verified' => false}

    @companies.should_receive(:insert).with(expected_insert_data).and_return(a_company)

    @company_creator.create(company_data);
  end


  it "builds a unique verification url" do
    company_data = {'email' => 'hello@company.com'}
    company = a_company
    @companies.stub(:insert).and_return(company)

    @verification_url_builder.should_receive('build').with(company)

    @company_creator.create(company_data)
  end


  it "sends an verification email when a new company is created" do
    expected_url = 'http:://verification-link'
    company = a_company
    @companies.should_receive(:insert).and_return(company)
    @verification_url_builder.stub(:build).and_return(expected_url)

    @company_creator.create({'name' => '', 'email' => 'hello@company.com', 'website' => ''});

    should have_sent_email.to(company.email)
    should have_sent_email.matching_body(/#{expected_url}/)
  end

  def a_company
    double('Company', {'email' => 'bartolo@guapo.es'})
  end

end