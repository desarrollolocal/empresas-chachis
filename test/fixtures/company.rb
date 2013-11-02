require_relative '../../app'
require 'mongo'
require 'json/ext'

include Mongo

database_settings = MyApp.settings.database
@database = MongoClient.new(database_settings["host"], database_settings["port"]).db(database_settings["name"])
@companies_collection = @database.collection("companies")
@companies_collection.insert("name" => "Aureka", "hiring" => true, "keywords" => ['tag1', 'tag2']);
@companies_collection.insert("name" => "startup molona", "hiring" => true, "keywords" => ['tag1', 'tag2']);
@companies_collection.insert("name" => "Vetaminic", "hiring" => false, "keywords" => ['tag1', 'tag2']);