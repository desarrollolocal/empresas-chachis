class KeywordProvider

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_from_hiring_companies
    companies = @collection.find({ "hiring" => true })
    keywords = []
    companies.each do |company|
      company['keywords'].each do |keyword|
        keywords << keyword
      end
    end
    keywords.uniq
  end
end