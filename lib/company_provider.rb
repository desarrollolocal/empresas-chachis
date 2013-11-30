require 'company'
require 'company_filters'

class CompanyProvider
  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_hiring(keyword = nil)
    filters = { 'hiring' => true }
    filters['keywords'] = /^#{keyword}$/i unless keyword.nil?
    
    find_by(filters)
  end

  private

  def find_by(filters)
    documents = @collection.find(filters).to_a
    convert_documents_to_companies(documents)
  end

  def convert_documents_to_companies(documents)
    documents.each do |attributes|
      build_new_company(attributes)
    end
  end

  def build_new_company(attributes)
    Company.new(attributes['name'], attributes['address'], attributes['website'], attributes['logo'], attributes['email'], attributes['keywords'])
  end

end