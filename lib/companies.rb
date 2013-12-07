class Companies

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def insert(company_data)
    @collection.insert(company_data)
  end
end