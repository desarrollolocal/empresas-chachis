class CompanyCreator

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def create(params)
    @collection.insert(prepare_insert(params))
  end

  private

  def prepare_insert(params)
    data = {'name' => params['name'], 'email' => params['email'], 'website' => params['website']}
    data["hiring"] = true
    data
  end
end
