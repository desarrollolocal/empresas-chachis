class CompanyProvider
  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_all
    @collection.find
  end

  def find_hiring
    @collection.find({ "hiring" => true })
  end
end