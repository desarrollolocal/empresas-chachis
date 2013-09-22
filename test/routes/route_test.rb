require_relative '../../app'
require 'rack/test'
require 'rspec'

describe "/" do
  include Rack::Test::Methods

  	def app
		MyApp.new
	end

	it "returns a response" do
	    get '/'
	    last_response.body.should include('Hello World')
	end

end
