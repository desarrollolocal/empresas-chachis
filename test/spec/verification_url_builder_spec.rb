require 'rspec'
require 'verification_url_builder'

describe 'VerificationUrlBuilder' do

  it 'builds an url from a company' do
    host = 'http://whatever.com'
    path = '/verify'
    builder = VerificationUrlBuilder.new(host, path)
    company = double('Company', {'id' => '478192371289'})

    url = builder.build(company)

    expect(url).to match /#{host}#{path}\/.+/
  end

end