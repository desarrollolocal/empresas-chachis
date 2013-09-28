require_relative '../../app'
require 'rspec'
require 'capybara'

describe "/" do
  include Capybara::DSL

  	before do
	    Capybara.app = MyApp.new
  	end

	it "shows all the companies" do
		expected_companies = 3
		visit '/'
	    page.all('.company').count.should eql expected_companies
	end

end
