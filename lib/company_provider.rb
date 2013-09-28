class CompanyProvider
  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_all
    @collection.find
  end
end