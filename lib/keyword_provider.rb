require 'company'

class KeywordProvider

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def find_all
    companies = @collection.find
    keywords = []
    companies.each do |company|
      company['keywords'].each do |keyword|
        keywords << keyword
      end
    end
    keywords.uniq
  end
end