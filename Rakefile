require 'rubygems'
require 'rspec/core/rake_task'


desc "Run server"
task :serverup do
	system "rackup -p 3000"
end

namespace :test do

	desc "Run functional tests"
	RSpec::Core::RakeTask.new(:functional) do |t|
	    t.pattern = "test/functional/*.rb"
	    t.rspec_opts = " -c"
	end

	desc "Run spec tests"
	RSpec::Core::RakeTask.new(:spec) do |t|
	    t.pattern = "test/spec/*.rb"
	    t.rspec_opts = " -c"
	end

	desc "Run all tests"
	task :all do
		Rake::Task['test:functional'].execute
		Rake::Task['test:spec'].execute
	end

end