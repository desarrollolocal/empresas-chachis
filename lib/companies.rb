require 'company'

class Companies

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def insert(company_data)
    id = @collection.insert(company_data)
    Company.new(id.to_s,
                company_data['name'],
                company_data['address'],
                company_data['website'],
                company_data['logo'],
                company_data['email'],
                company_data['keywords'],
                company_data['description'],
                )
  end

  def find_hiring(keyword = nil)
    filters = { 'hiring' => true, 'verified' => true  }
    filters['keywords'] = /^#{keyword}$/i unless keyword.nil?

    find_by(filters)
  end

  def update(id, company_data)
    object_id = BSON::ObjectId(id)
    @collection.update({'_id' => object_id}, {"$set" => company_data})
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
    Company.new(attributes['name'], attributes['address'], attributes['website'], attributes['logo'], attributes['email'], attributes['keywords'], attributes['verified'])
  end
end