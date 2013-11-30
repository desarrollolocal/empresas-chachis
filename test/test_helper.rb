ENV['RACK_ENV'] = 'test'
require_relative '../app'
require 'rspec'
require 'capybara'
require 'mongo'
require 'json/ext'

include Mongo

Mail.defaults do
  delivery_method :test
end