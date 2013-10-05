require_relative '../lib/company'

class CompanyProvider
  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_all
    @collection.find.to_a.each do |attributes|
      build_new_company(attributes)
    end
  end

  def find_hiring
    @collection.find({ "hiring" => true }).to_a.each do |attributes|
      build_new_company(attributes)
    end
  end

  private 

  def build_new_company(attributes)
    Company.new(attributes['name'], attributes['address'], attributes['website'], attributes['logo'], attributes['email'], attributes['keywords'])
  end
end