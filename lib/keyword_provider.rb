class KeywordProvider

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_from_hiring_companies
    keywords = {}
    all_keywords.each do |keyword|
        keywords[keyword] = 0 if keywords[keyword].nil?
        keywords[keyword]= keywords[keyword] +1
    end

    return keywords
  end

  private

  def all_keywords
    companies = @collection.find({ "hiring" => true })
    companies.map {|company| company['keywords'] }.flatten
  end

end