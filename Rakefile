require 'rubygems'
require 'rspec/core/rake_task'


desc "Run server"
task :serverup do
	system "rackup -p 3000"
end

namespace :test do

	desc "Run routes tests"
	RSpec::Core::RakeTask.new(:routes) do |t|
	    t.pattern = "test/routes/*.rb"
	    t.rspec_opts = " -c"
	end

	desc "Run domain tests"
	RSpec::Core::RakeTask.new(:domain) do |t|
	    t.pattern = "test/domain/*.rb"
	    t.rspec_opts = " -c"
	end

	desc "Run all tests"
	task :all do
		Rake::Task['test:domain'].execute
		Rake::Task['test:routes'].execute
	end

end