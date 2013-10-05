require 'mongo'
require 'json/ext'

include Mongo

@database = MongoClient.new("localhost", 27017).db("empresaschachis_test")
@companies_collection = @database.collection("companies")
@companies_collection.insert("name" => "Aureka", "hiring" => true, "keywords" => ['tag1', 'tag2']);
@companies_collection.insert("name" => "Vetaminic", "hiring" => false, "keywords" => ['tag1', 'tag2']);